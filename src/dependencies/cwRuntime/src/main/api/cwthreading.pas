{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )

  Redistribution and use in source and binary forms, with or without modification,
  are permitted provided that the following conditions are met:

  1. Redistributions of source code must retain the above copyright notice,
     this list of conditions and the following disclaimer.

  2. Redistributions in binary form must reproduce the above copyright notice,
     this list of conditions and the following disclaimer in the documentation and/or
     other materials provided with the distribution.

  3. Neither the name of the copyright holder nor the names of its contributors may be
     used to endorse or promote products derived from this software without specific prior
     written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
  IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)
{$endif}
unit cwThreading;
{$ifdef fpc}
  {$mode delphiunicode}
  {$modeswitch nestedprocvars}
{$endif}

interface
uses
  cwStatus
;

{$region ' Status messages'}
resourcestring
  stThreadSleepFailed           = '{66B2F278-764D-4746-92A1-06BC71C1A5DD} Failed to put thread to sleep.';
  stErrorInsertingTasks         = '{6281E70E-88EE-45BD-AA5E-133668655ACC} Failed to insert tasks into task pool, pool corrupted?';
  stThreadTerminteFailed        = '{F4C513FD-683B-4CE0-8B52-0E89C4C8AD83} Failed to terminate thread.';
  stThreadStartupFailed         = '{1F66A81D-7507-4263-A9B3-455A7AEC12B6} Failed to start threads.';
  stThreadCreateFailed          = '{50BFFEA8-6B70-4043-BCC6-8383F8487E17} Failed to create thread.';
  stThreadAffinityFailed        = '{63B9FF8F-C118-44C3-977C-61738EBE1F96} Failed to set thread affinity.';
  stNoTaskAssigned              = '{F76CD775-244C-413A-B6FC-7F7BEC439DAD} Task not assigned on call to ITreadingSystem.Execute().';
  stCreateMutxFailed            = '{028BFADB-DFE0-4768-BD32-1FED8F34CEC3} Failed to create mutext for critical section with code (%retcode%).';
  stInitMutexFailed             = '{212F5D31-7D3A-497F-9BAB-399B33FAEC5E} Failed to initialize mutex for critical section with code (%retcode%).';
  stInitConditionVariableFailed = '{7E8F0197-A3AB-487D-B192-1B75BC415431} Failed to initialize condition variable with code (%retcode%).';
  stThreadAttrInitFailed        = '{D096FDC2-2A2F-48E1-8403-2125A8619EC2} pthread_attr_init() failed with code (%retcode%).';
  stThreadStackSetFailed        = '{66AF3455-42F6-4370-91E8-1DC19358DD54} pthread_attr_setstacksize() failed with code (%retcode%).';
  stThreadAttrFnitFailed        = '{ECDF9AB8-E6D4-4617-B483-C306209F7E23} pthread_attr_destroy() failed with code (%retcode%).';
  stThreadJoinFailed            = '{2677B0F3-B413-4760-9303-780D0D7DAFC9} pthread_join() failed with code (%retcode%).';
  stPostMessageDeniedToThread   = '{49478226-3B0C-4D4C-93D9-E33A6371CD26} Only the thread for which a message channel was created may use the channel to Send/Post messages.';
  stThreadMessageChannelFull    = '{D4367D2B-72BB-4C2C-8113-79074B293353} The message channel is full. Retry sending, the target thread may be under load.';
  stMessagedThreadUniqueName    = '{BE1335B3-D9CA-4A5E-A5FA-DA342E04EB47} Messaged threads must have a unique name.';
{$endregion}

{$region ' Critical Section'}
type
  ///  <summary>
  ///    Represents a mutex lock which may be used to protect a critical
  ///    section of code, which must be executed by only one thread at any
  ///    time.
  ///  </summary>
  ICriticalSection = interface
    ['{21F4E11C-C165-4473-82C0-1674EBD90678}']

    ///  <summary>
    ///    Acquire the mutex lock. A thread should call this to ensure that
    ///    it is executing exclusively.
    ///  </summary>
    procedure Acquire;

    ///  <summary>
    ///    Release the mutex lock. A thread calls this method to release it's
    ///    exclusive execution.
    ///  </summary>
    procedure Release;
  end;

{$endregion}

{$region ' Signaled Critical Section'}
type
  ///  <summary>
  ///    Represents a critical section controlled by a condition variable. <br/>
  ///    This works in the same way as an ICriticalSection, except that a
  ///    thread can put it's self to sleep (releasing the mutex), until it
  ///    is woken by an external signal from another thread. Once woken the
  ///    thread re-aquires the mutex lock and continues execution.
  ///  </summary>
  ISignaledCriticalSection = interface
    ['{89D86C88-78BB-4FD5-AE68-BFF81C035BF0}']

    ///  <summary>
    ///    Acquire the mutex lock. A thread should call this to ensure that
    ///    it is executing exclusively.
    ///  </summary>
    procedure Acquire;

    ///  <summary>
    ///    Release the mutex lock. A thread calls this method to release it's
    ///    exclusive execution.
    ///  </summary>
    procedure Release;

    ///  <summary>
    ///    Causes the calling thread to release the mutex lock and begin
    ///    sleeping. While sleeping, the calling thread is excluded from the
    ///    thread scheduler, allowing other threads to consume it's runtime.
    ///    <remarks>
    ///      Sleep may return at any time, regardless of the work having been
    ///      completed. You should check that the work has actually been
    ///      completed, and if not, put the signaled critical seciton back
    ///      to sleep.
    ///    </remarks>
    ///  </summary>
    procedure Sleep;

    ///  <summary>
    ///    Called by some external thread, Wake causes the sleeping thread to
    ///    re-aquire the mutex lock and to continue executing.
    ///  </summary>
    procedure Wake;
  end;

{$endregion}

{$region ' OnComplete notification'}

type
  /// <summary>
  ///   A callback to procedure to notify when all tasks added to an
  ///   execute call have completed. See IThreadSystem.Execute().
  /// </summary>
  {$ifndef fpc}
  TOnComplete = reference to procedure;
  {$else}
  /// <exclude/>
  TOnCompleteGlobal = procedure;
  /// <exclude/>
  TOnCompleteOfObject = procedure of object;
  /// <exclude/>
  TOnCompleteNested = procedure is nested;
  {$endif}

{$endregion}

{$region ' OnExecute action '}

type
  /// <summary>
  ///   A callback to perform 'for-loop' style execution.
  ///   The total amount of work for the loop is divided up across the
  ///   available number of threads in the task pool. Each call to
  ///   the execute action contains a start and stop parameter index which
  ///   describes the portion of the loop that it is responsible for. <br/>
  /// </summary>
  {$ifndef fpc}
  TOnExecute = reference to procedure( const start: nativeuint; const stop: nativeuint );
  {$else}
  /// <exclude/>
  TOnExecuteGlobal = procedure( const start: nativeuint; const stop: nativeuint );
  /// <exclude/>
  TOnExecuteOfObject = procedure( const start: nativeuint; const stop: nativeuint ) of object;
  /// <exclude/>
  TOnExecuteNested = procedure( const start: nativeuint; const stop: nativeuint ) is nested;
  {$endif}

{$endregion}

{$region ' Task'}

type
  /// <summary>
  ///   Provide an implementation of ITask to perform some action within
  ///   a task pool. When a task is added to a task pool, it will be executed
  ///   once and then disposed.
  /// </summary>
  ITask = interface
    ['{00D703E1-ACE3-4BF5-B349-A1FB9FA9D4AE}']

    ///  <summary>
    ///    Method to be executed once by a task pool.
    ///  </summary>
    procedure Execute;
  end;
{$endregion}

{$region ' Thread '}
type

  /// <summary>
  ///   Provide an implementation of thread to be executed by a task system. <br/>
  ///   The task system will repeatedly call ILongThread.Execute until it returns
  ///   false, or until the thread system is terminated.
  /// </summary>
  ILongThread = interface
    ['{DD87DBD1-EA4D-4841-8D58-BC9785DA93CF}']

    /// <summary>
    ///   Your method to be called repeatedly until it returns false, or until
    ///   the thread system hosting it is terminated.
    /// </summary>
    function Execute(): boolean;
  end;

{$endregion}

{$region ' Message Parameter'}
type

  ///  <summary>
  ///    A parameter component of TMessage (see TMessage) <br/>
  ///    A TMessageParameter is a record with a size equal to a pointer for
  ///    the target system. It has advanced-record overloading to allow it
  ///    to be used interchangably as a pointer or a nativeuint. <br/>
  ///  </summary>
  TMessageParameter = record
    Param: nativeuint;
    /// <exclude/>
    class operator Implicit(const a: TMessageParameter): nativeuint;
    /// <exclude/>
    class operator Explicit(const a: TMessageParameter): nativeuint;
    /// <exclude/>
    class operator Implicit(const a: TMessageParameter): pointer;
    /// <exclude/>
    class operator Explicit(const a: TMessageParameter): pointer;
    /// <exclude/>
    class operator Implicit(const a: nativeuint): TMessageParameter;
    /// <exclude/>
    class operator Explicit(const a: nativeuint): TMessageParameter;
    /// <exclude/>
    class operator Implicit(const a: pointer): TMessageParameter;
    /// <exclude/>
    class operator Explicit(const a: pointer): TMessageParameter;
    /// <exclude/>
    class operator Equal( const a: nativeuint; const b: TMessageParameter ): boolean;
    /// <exclude/>
    class operator Equal( const a: TMessageParameter; const b: nativeuint ): boolean;
    /// <exclude/>
    class operator NotEqual( const a: nativeuint; const b: TMessageParameter ): boolean;
    /// <exclude/>
    class operator NotEqual( const a: TMessageParameter; const b: nativeuint ): boolean;
    /// <exclude/>
    class operator Equal( const a: pointer; const b: TMessageParameter ): boolean;
    /// <exclude/>
    class operator Equal( const a: TMessageParameter; const b: pointer ): boolean;
    /// <exclude/>
    class operator NotEqual( const a: pointer; const b: TMessageParameter ): boolean;
    /// <exclude/>
    class operator NotEqual( const a: TMessageParameter; const b: pointer ): boolean;
    /// <exclude/>
    class operator Equal( const a: TMessageParameter; const b: TMessageParameter ): boolean;
    /// <exclude/>
    class operator NotEqual( const a: TMessageParameter; const b: TMessageParameter ): boolean;
  end;

{$endregion}

{$region ' Message'}

type
  /// <summary>
  ///   TMessage represents a signal that may be sent from one thread to
  ///   another. <br/>
  ///   It consists of a value, and up to four optional parameters labeled
  ///   A, B, C and D respectively. Each parameter is of size=sizeof(pointer)
  ///   and may be supplied as either a nativeuint or a pointer to one of the
  ///   overloaded Create() methods. <br/>
  ///   TMessage may also be cast implicitly as a nativeuint for use in a case
  ///   statement. i.e.: Case aMessage of .... <br/>
  /// </summary>
  TMessage = record
    Value: nativeuint;
    A: nativeuint;
    B: nativeuint;
    C: nativeuint;
    D: nativeuint;

    /// <exclude/>
    class operator Implicit(const a: TMessage): nativeuint;
    /// <exclude/>
    class operator Explicit(const a: TMessage): nativeuint;
    /// <exclude/>
    class operator Implicit(const a: nativeuint): TMessage;
    /// <exclude/>
    class operator Explicit(const a: nativeuint): TMessage;

    /// <summary>
    ///   This overload of Create() enables the creation of a message without any parameters.
    /// </summary>
    class function Create( const Value: nativeuint ): TMessage; overload; static;
    /// <summary>
    ///   This overload of Create() enables the creation of a message a single parameter.
    /// </summary>
    class function Create( const Value: nativeuint; A: TMessageParameter ): TMessage; overload; static;
    /// <summary>
    ///   This overload of Create() enables the creation of a message two parameters.
    /// </summary>
    class function Create( const Value: nativeuint; A, B: TMessageParameter ): TMessage; overload; static;
    /// <summary>
    ///   This overload of Create() enables the creation of a message three parameters.
    /// </summary>
    class function Create( const Value: nativeuint; A, B, C: TMessageParameter ): TMessage; overload; static;
    /// <summary>
    ///   This overload of Create() enables the creation of a message four parameters.
    /// </summary>
    class function Create( const Value: nativeuint; A, B, C, D: TMessageParameter ): TMessage; overload; static;
  end;

{$endregion}

{$region ' Messaged thread'}

type
  ///  <summary>
  ///    Provide an implementation of messaged thread to be executed by the thread system. <br/>
  ///    An IMessagedThread will put it's self to sleep, removing it's self from the system thread
  ///    scheduler, until a message is sent to it. When a message is sent to the message thread,
  ///    it will be woken and will call the IMessageThread.HandleMessage() method. <br/>
  ///  </summary>
  IMessagedThread = interface
    ['{77E0D5AF-B97B-4307-B25C-9019E8073A8F}']

    ///  <summary>
    ///    The thread system will call HandleMessage each time a message is
    ///    sent to this thread. <br/> Your implementation should return as
    ///    quickly as possible.
    ///  </summary>
    procedure HandleMessage( const Message: TMessage );
  end;
{$endregion}

{$region ' IMessageChannel'}
type
  ///  <summary>
  ///    An instance of IMessageChannel represents a communications channel
  ///    into a running IMessagedThread.
  ///    <br/> <b> Cross-Thread Restriction </b> <br/>
  ///    Returned from a call to IThreadSystem.getMessageChannel(), an instance
  ///    of IMessageChannel is unique to the thread which called
  //     getMessageChannel() and must not be shared among threads. <br/>
  ///    For example, if thread 'A' wishes to communicate with thread 'B' then
  ///    thread 'A' calls IThreadSystem.getMessageChannel('B'), and retains a
  ///    reference to the message channel which is returned. This reference may
  ///    not be passed to thread 'C' to enable it to communciate with thread 'B'. <br/>
  ///    Thread 'C' must make it's own call to IThreadSystem.getMessageChannel('B')
  ///    in order to communicate with thread 'B'. <br/>
  ///    The cross-thread restriction IS enforced such that an attempt to violate
  ///    this restriction will result in an ECrossThreadViolation exception
  ///    being raised.
  ///  </summary>
  IMessageChannel = interface
    ['{AF7FD0D3-FB9E-4DC1-8D1A-E2AD947B9D55}']

    ///  <summary>
    ///    Sends a message to the thread to which this message channel belongs,
    ///    and returns immediately, without waiting for the thread to handle
    ///    the message. <br/>
    ///    PostMessage may fail if the message channel is full, or if the
    ///    message channel is being used by a thread other than the one for
    ///    which it was created.
    ///  </summary>
    function PostMessage( const Message: TMessage ): TStatus;

    ///  <summary>
    ///    Sends a message to the thread to which this message channel belongs,
    ///    and waits until the thread has handled the message.
    ///    SendMessage may fail if the message channel is full, or if the
    ///    message channel is being used by a thread other than the one for
    ///    which it was created.
    ///  </summary>
    function SendMessage( const Message: TMessage ): TStatus;
  end;

{$endregion}

{$region ' Threading system'}

type
  ///  <summary>
  ///    An IThreadingSystem is a scheduler for marshalling both long and
  ///    short running threads. <br/>
  ///    cwThreading provides a singleton instance of IThreadingSystem which
  ///    is returned from cwThreading.Standard.ThreadingSystem. <br/>
  ///  </summary>
  IThreadingSystem = interface
    ['{FE38A927-61DA-4069-B26F-5BA3DE100266}']

    {$region ' Task pool execute methods}

    {$ifndef fpc}
    ///  <summary>
    ///    This overload of execute inserts an array of tasks into the
    ///    task pool to be executed. When execution of the tasks is complete,
    ///    each task will be removed from the pool and disposed by reference. <br/>
    ///    A method may be provided to be called when execution of tasks is complete. <br/>
    ///    This overload is specific to Delphi because it accepts a reference
    ///    to a method to be called upon completion of th tasks. FreePascal
    ///    does not currently support anonymous methods, and so it has
    ///    global, of object and nested overloads instead. <br/>
    ///    Under Delphi, anonymous methods may be used, however, if you wish
    ///    to keep code compatible with FPC avoid using anonymous methods and
    ///    select a global, of object or nested method instead.
    ///  </summary>
    procedure Execute( const Tasks: array of ITask; const WhenDone: TOnComplete ); overload;
    {$else}
    ///  <summary>
    ///    This overload of execute inserts an array of tasks into the
    ///    task pool to be executed. When execution of the tasks is complete,
    ///    each task will be removed from the pool and disposed by reference. <br/>
    ///    A global procedure may be provided to be called upon completion of the
    ///    tasks.
    ///  </summary>
    procedure Execute( const Tasks: array of ITask; const WhenDone: TOnCompleteGlobal ); overload;
    ///  <summary>
    ///    This overload of execute inserts an array of tasks into the
    ///    task pool to be executed. When execution of the tasks is complete,
    ///    each task will be removed from the pool and disposed by reference. <br/>
    ///    An object method may be provided to be called upon completion of the
    ///    tasks.
    ///  </summary>
    procedure Execute( const Tasks: array of ITask; const WhenDone: TOnCompleteOfObject ); overload;
    ///  <summary>
    ///    This overload of execute inserts an array of tasks into the
    ///    task pool to be executed. When execution of the tasks is complete,
    ///    each task will be removed from the pool and disposed by reference. <br/>
    ///    An nested method may be provided to be called upon completion of the
    ///    tasks.
    ///  </summary>
    procedure Execute( const Tasks: array of ITask; const WhenDone: TOnCompleteNested ); overload;
    {$endif}
    ///  <summary>
    ///    This overload of execute inserts an array of tasks into the
    ///    task pool to be executed. When execution of the tasks is complete,
    ///    each task will be removed from the pool and disposed by reference. <br/>
    ///    The optional 'WaitFor' parameter may be set true in order to cause
    ///    the calling thread to sleep until the tasks are completed.
    ///  </summary>
    procedure Execute( const Tasks: array of ITask; const WaitFor: boolean = False ); overload;

    {$endregion}

    {$region ' For loop execute methods}

    {$ifndef fpc}
    ///  <summary>
    ///    This overload of execute allows for parallelization of a for loop.
    ///    The 'TotalWorkItems' is divided across the available threads and
    ///    the OnExecuteAction() method is called by each thread, supplying
    ///    the action method with 'start' and 'stop' values to indicate
    ///    which portion of the for loop the method is responsible for
    ///    executing. <br/>
    ///    The 'WhenDone' event is fired upon completion of the for loop to
    ///    notify the caller that work has been completed. <br>
    ///    This overload is specific to Delphi as it accepts a 'reference to'
    ///    method for both its 'OnExecuteAction' and its 'WhenDone' parameters. <br/>
    ///    FreePascal does not currently support anonymous methods and as such,
    ///    overloads have been added to support Global Procedures, Object Methods,
    ///    and Nested procedures for both the 'OnExecuteAction' and the
    ///    'WhenDone' callbacks. Under Delphi you may use an anonymous method,
    ///    however, if you wish to keep your code compatible with FreePascal
    ///    you must choose one of the other method types instead.
    ///  </summary>
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecute; const WhenDone: TOnComplete ); overload;

    ///  <summary>
    ///    This overload of execute allows for parallelization of a for loop.
    ///    The 'TotalWorkItems' is divided across the available threads and
    ///    the OnExecuteAction() method is called by each thread, supplying
    ///    the action method with 'start' and 'stop' values to indicate
    ///    which portion of the for loop the method is responsible for
    ///    executing. <br/>
    ///    The optional 'WaitFor' parameter, when set TRUE, causes the calling
    ///    thread to sleep until all of the work has been completed.
    ///    This overload is specific to Delphi, allowing a 'reference to'
    ///    method to be used for the 'OnExecuteAction' parameter. <br/>
    ///    FreePascal does not currently support anonymous methods and as such,
    ///    overloads have been added to support Global Procedures, Object Methods,
    ///    and Nested procedures for the 'OnExecuteAction'. Under Delphi you may
    ///    use an anonymous method, however, if you wish to keep your code
    ///    compatible with FreePascal you must choose one of the other method
    ///    types instead.
    ///  </summary>
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecute; const WaitFor: boolean = False ); overload;
    {$else}

    ///  <summary>
    ///    This overload of execute allows for parallelization of a for loop.
    ///    The 'TotalWorkItems' is divided across the available threads and
    ///    the OnExecuteAction() method is called by each thread, supplying
    ///    the action method with 'start' and 'stop' values to indicate
    ///    which portion of the for loop the method is responsible for
    ///    executing. <br/>
    ///    The optional 'WaitFor' parameter, when set TRUE, causes the calling
    ///    thread to sleep until all of the work has been completed.
    ///    This overload allows for a global procedure for the 'OnExecuteAction'
    ///    parameter.
    ///  </summary>
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteGlobal; const WaitFor: boolean = False ); overload;

    ///  <summary>
    ///    This overload of execute allows for parallelization of a for loop.
    ///    The 'TotalWorkItems' is divided across the available threads and
    ///    the OnExecuteAction() method is called by each thread, supplying
    ///    the action method with 'start' and 'stop' values to indicate
    ///    which portion of the for loop the method is responsible for
    ///    executing. <br/>
    ///    The optional 'WaitFor' parameter, when set TRUE, causes the calling
    ///    thread to sleep until all of the work has been completed.
    ///    This overload allows for an object method for the 'OnExecuteAction'
    ///    parameter.
    ///  </summary>
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteOfObject; const WaitFor: boolean = False ); overload;

    ///  <summary>
    ///    This overload of execute allows for parallelization of a for loop.
    ///    The 'TotalWorkItems' is divided across the available threads and
    ///    the OnExecuteAction() method is called by each thread, supplying
    ///    the action method with 'start' and 'stop' values to indicate
    ///    which portion of the for loop the method is responsible for
    ///    executing. <br/>
    ///    The optional 'WaitFor' parameter, when set TRUE, causes the calling
    ///    thread to sleep until all of the work has been completed.
    ///    This overload allows for a nested procedure for the 'OnExecuteAction'
    ///    parameter.
    ///  </summary>
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteNested; const WaitFor: boolean = False ); overload;

    ///  <summary>
    ///    This overload of execute allows for parallelization of a for loop.
    ///    The 'TotalWorkItems' is divided across the available threads and
    ///    the OnExecuteAction() method is called by each thread, supplying
    ///    the action method with 'start' and 'stop' values to indicate
    ///    which portion of the for loop the method is responsible for
    ///    executing. <br/>
    ///    The 'WhenDone' event is fired upon completion of the for loop to
    ///    notify the caller that work has been completed. <br>
    ///    This overload allows for a global procedure for the 'OnExecuteAction'
    ///    parameter, and a global procedure for the 'WhenDone' parameter.
    ///  </summary>
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteGlobal; const WhenDone: TOnCompleteGlobal ); overload;

    ///  <summary>
    ///    This overload of execute allows for parallelization of a for loop.
    ///    The 'TotalWorkItems' is divided across the available threads and
    ///    the OnExecuteAction() method is called by each thread, supplying
    ///    the action method with 'start' and 'stop' values to indicate
    ///    which portion of the for loop the method is responsible for
    ///    executing. <br/>
    ///    The 'WhenDone' event is fired upon completion of the for loop to
    ///    notify the caller that work has been completed. <br>
    ///    This overload allows for an object method for the 'OnExecuteAction'
    ///    parameter, and a global procedure for the 'WhenDone' parameter.
    ///  </summary>
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteOfObject; const WhenDone: TOnCompleteGlobal ); overload;

    ///  <summary>
    ///    This overload of execute allows for parallelization of a for loop.
    ///    The 'TotalWorkItems' is divided across the available threads and
    ///    the OnExecuteAction() method is called by each thread, supplying
    ///    the action method with 'start' and 'stop' values to indicate
    ///    which portion of the for loop the method is responsible for
    ///    executing. <br/>
    ///    The 'WhenDone' event is fired upon completion of the for loop to
    ///    notify the caller that work has been completed. <br>
    ///    This overload allows for a nested procedure for the 'OnExecuteAction'
    ///    parameter, and a global procedure for the 'WhenDone' parameter.
    ///  </summary>
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteNested; const WhenDone: TOnCompleteGlobal ); overload;

    ///  <summary>
    ///    This overload of execute allows for parallelization of a for loop.
    ///    The 'TotalWorkItems' is divided across the available threads and
    ///    the OnExecuteAction() method is called by each thread, supplying
    ///    the action method with 'start' and 'stop' values to indicate
    ///    which portion of the for loop the method is responsible for
    ///    executing. <br/>
    ///    The 'WhenDone' event is fired upon completion of the for loop to
    ///    notify the caller that work has been completed. <br>
    ///    This overload allows for a global procedure for the 'OnExecuteAction'
    ///    parameter, and an object method for the 'WhenDone' parameter.
    ///  </summary>
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteGlobal; const WhenDone: TOnCompleteOfObject ); overload;

    ///  <summary>
    ///    This overload of execute allows for parallelization of a for loop.
    ///    The 'TotalWorkItems' is divided across the available threads and
    ///    the OnExecuteAction() method is called by each thread, supplying
    ///    the action method with 'start' and 'stop' values to indicate
    ///    which portion of the for loop the method is responsible for
    ///    executing. <br/>
    ///    The 'WhenDone' event is fired upon completion of the for loop to
    ///    notify the caller that work has been completed. <br>
    ///    This overload allows for an object method for the 'OnExecuteAction'
    ///    parameter, and an object method for the 'WhenDone' parameter.
    ///  </summary>
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteOfObject; const WhenDone: TOnCompleteOfObject ); overload;

    ///  <summary>
    ///    This overload of execute allows for parallelization of a for loop.
    ///    The 'TotalWorkItems' is divided across the available threads and
    ///    the OnExecuteAction() method is called by each thread, supplying
    ///    the action method with 'start' and 'stop' values to indicate
    ///    which portion of the for loop the method is responsible for
    ///    executing. <br/>
    ///    The 'WhenDone' event is fired upon completion of the for loop to
    ///    notify the caller that work has been completed. <br>
    ///    This overload allows for a nested procedure for the 'OnExecuteAction'
    ///    parameter, and an object method for the 'WhenDone' parameter.
    ///  </summary>
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteNested; const WhenDone: TOnCompleteOfObject ); overload;

    ///  <summary>
    ///    This overload of execute allows for parallelization of a for loop.
    ///    The 'TotalWorkItems' is divided across the available threads and
    ///    the OnExecuteAction() method is called by each thread, supplying
    ///    the action method with 'start' and 'stop' values to indicate
    ///    which portion of the for loop the method is responsible for
    ///    executing. <br/>
    ///    The 'WhenDone' event is fired upon completion of the for loop to
    ///    notify the caller that work has been completed. <br>
    ///    This overload allows for a global procedure for the 'OnExecuteAction'
    ///    parameter, and a nested procedure for the 'WhenDone' parameter.
    ///  </summary>
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteGlobal; const WhenDone: TOnCompleteNested ); overload;

    ///  <summary>
    ///    This overload of execute allows for parallelization of a for loop.
    ///    The 'TotalWorkItems' is divided across the available threads and
    ///    the OnExecuteAction() method is called by each thread, supplying
    ///    the action method with 'start' and 'stop' values to indicate
    ///    which portion of the for loop the method is responsible for
    ///    executing. <br/>
    ///    The 'WhenDone' event is fired upon completion of the for loop to
    ///    notify the caller that work has been completed. <br>
    ///    This overload allows for an object method for the 'OnExecuteAction'
    ///    parameter, and a nested procedure for the 'WhenDone' parameter.
    ///  </summary>
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteOfObject; const WhenDone: TOnCompleteNested ); overload;

    ///  <summary>
    ///    This overload of execute allows for parallelization of a for loop.
    ///    The 'TotalWorkItems' is divided across the available threads and
    ///    the OnExecuteAction() method is called by each thread, supplying
    ///    the action method with 'start' and 'stop' values to indicate
    ///    which portion of the for loop the method is responsible for
    ///    executing. <br/>
    ///    The 'WhenDone' event is fired upon completion of the for loop to
    ///    notify the caller that work has been completed. <br>
    ///    This overload allows for a nested procedure for the 'OnExecuteAction'
    ///    parameter, and a nested procedure for the 'WhenDone' parameter.
    ///  </summary>
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteNested; const WhenDone: TOnCompleteNested ); overload;
    {$endif}

    {$endregion}

    ///  <summary>
    ///    This overload of execute installs a long running thread into the
    ///    thread system. This thread will be executed repeatedly (by call to
    ///    it's execute() method) until either the execute method returns false
    ///    or the thread system is shut down. <br/>
    ///    Threads are expected to execute their tasks quickly and return from
    ///    their execute method such that the threading system may control their
    ///    terminate in a timely mannor.
    ///  </summary>
    procedure Execute( const Threads: array of ILongThread ); overload;

    ///  <summary>
    ///    This overload of execute installs a named thread which will run only
    ///    in response to receiving a message. While the thread is not handling
    ///    a message it is put to sleep, removing it from the operating system
    ///    sheduler such that it will not consume cpu cycles. <br/>
    ///    When a message is sent to the IMessagedThread.HandleMessage() method,
    ///    it is expected to complete as quickly as possible in order that
    ///    the thread be put back to sleep, or terminated in a timely mannor. <br/>
    ///    A messaged thread may also be terminated by removing it from the
    ///    thread system with a call to IThreadSystem.Remove().
    ///  </summary>
    procedure Execute( const ThreadName: string; const MessagedThread: IMessagedThread ); overload;

    ///  <summary>
    ///    Returns an instance of IMessageChannel which may be used to
    ///    communicate with a MessagedThread. <br/>
    ///    NOTE: The thread name is Case-Sensitive. <br/>
    ///  </summary>
    function getMessageChannel( const ThreadName: string ): IMessageChannel;

    ///  <summary>
    ///    Removes a long running thread from the thread system.
    ///  </summary>
    procedure Remove( const Thread: ILongThread ); overload;

    ///  <summary>
    ///    Terminates and removes a named message thread from the thread system. <br/>
    ///    This overload locates the thread by it's name.
    ///  </summary>
    procedure Remove( const ThreadName: string ); overload;

    ///  <summary>
    ///    Terminates and removes a named message thread from the thread system. <br/>
    ///    This overload locates the thread by it's reference.
    ///  </summary>
    procedure Remove( const MessagedThread: IMessagedThread ); overload;

  end;

{$endregion}

implementation

{$region ' TMessage '}

class operator TMessage.Implicit(const a: TMessage): nativeuint;
begin
  Result := a.Value;
end;

class operator TMessage.Explicit(const a: TMessage): nativeuint;
begin
  Result := a.Value;
end;

class operator TMessage.Implicit(const a: nativeuint): TMessage;
begin
  Result.Value := a;
end;

class operator TMessage.Explicit(const a: nativeuint): TMessage;
begin
  Result.Value := a;
end;

class function TMessage.Create(const Value: nativeuint): TMessage;
begin
  Result.Value := Value;
  Result.A := 0;
  Result.B := 0;
  Result.C := 0;
  Result.D := 0;
end;

class function TMessage.Create(const Value: nativeuint; A: TMessageParameter): TMessage;
begin
  Result.Value := Value;
  Result.A := A;
  Result.B := 0;
  Result.C := 0;
  Result.D := 0;
end;

class function TMessage.Create(const Value: nativeuint; A, B: TMessageParameter): TMessage;
begin
  Result.Value := Value;
  Result.A := A;
  Result.B := B;
  Result.C := 0;
  Result.D := 0;
end;

class function TMessage.Create(const Value: nativeuint; A, B, C: TMessageParameter): TMessage;
begin
  Result.Value := Value;
  Result.A := A;
  Result.B := B;
  Result.C := C;
  Result.D := 0;
end;

class function TMessage.Create(const Value: nativeuint; A, B, C, D: TMessageParameter): TMessage;
begin
  Result.Value := Value;
  Result.A := A;
  Result.B := B;
  Result.C := C;
  Result.D := D;
end;

{$endregion}

{$region ' TMessageParameter'}

class operator TMessageParameter.Implicit(const a: TMessageParameter): nativeuint;
begin
  Result := a.Param;
end;

class operator TMessageParameter.Explicit(const a: TMessageParameter): nativeuint;
begin
  Result := a.Param;
end;

class operator TMessageParameter.Implicit(const a: TMessageParameter): pointer;
begin
  {$hints off} Result := pointer( a.Param ); {$hints on}
end;

class operator TMessageParameter.Explicit(const a: TMessageParameter): pointer;
begin
  Result := {$hints off} pointer( a.Param ); {$hints on}
end;

class operator TMessageParameter.Implicit(const a: nativeuint): TMessageParameter;
begin
  Result.Param := a;
end;

class operator TMessageParameter.Explicit(const a: nativeuint): TMessageParameter;
begin
  Result.Param := a;
end;

class operator TMessageParameter.Implicit(const a: pointer): TMessageParameter;
begin
  {$hints off} Result.Param := nativeuint(a); {$hints on}
end;

class operator TMessageParameter.Explicit(const a: pointer): TMessageParameter;
begin
  {$hints off} Result.Param := nativeuint(a); {$hints on}
end;

class operator TMessageParameter.Equal(const a: nativeuint; const b: TMessageParameter): boolean;
begin
  Result := a = b.Param;
end;

class operator TMessageParameter.Equal(const a: TMessageParameter; const b: nativeuint): boolean;
begin
  Result := a.Param = b;
end;

class operator TMessageParameter.NotEqual(const a: nativeuint; const b: TMessageParameter): boolean;
begin
  Result := a <> b.Param;
end;

class operator TMessageParameter.NotEqual(const a: TMessageParameter; const b: nativeuint): boolean;
begin
  Result := a.Param<>b;
end;

class operator TMessageParameter.Equal(const a: pointer; const b: TMessageParameter): boolean;
begin
  {$hints off} Result := nativeuint(a) = b.Param; {$hints on}
end;

class operator TMessageParameter.Equal(const a: TMessageParameter; const b: pointer): boolean;
begin
  {$hints off} Result := a.Param = nativeuint(b); {$hints on}
end;

class operator TMessageParameter.NotEqual(const a: pointer; const b: TMessageParameter): boolean;
begin
  {$hints off} Result := nativeuint(a) <> b.Param; {$hints on}
end;

class operator TMessageParameter.NotEqual(const a: TMessageParameter; const b: pointer): boolean;
begin
  {$hints off} Result := a.Param <> nativeuint(b); {$hints on}
end;

class operator TMessageParameter.Equal(const a: TMessageParameter; const b: TMessageParameter): boolean;
begin
  Result := a.Param = b.Param;
end;

class operator TMessageParameter.NotEqual(const a: TMessageParameter; const b: TMessageParameter): boolean;
begin
  Result := a.Param <> b.Param;
end;

{$endregion}

end.

