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
unit cwThreading.Internal;
{$ifdef fpc}{$mode delphiunicode}{$endif}

(*
   This unit contains internally used interfaces.
*)

interface
uses
  cwThreading
;

{$region ' IThread / ThreadPool'}
type
  IThread = interface; // forward

  //- Executed by threads in a thread pool.
  //- This method can/should be long running but should frequenstly check
  //- Thread.TerminateFlag to see if it should end.
  TThreadExecuteMethod = procedure( const Thread: IThread ) of object;

  //- An interface to wrap threads created by the system.
  //- Handling of life-cycle to be specified in implementation constructor.
  IThread = interface
    ['{9BD6445C-2E48-4A89-B642-D72A84365151}']

    //- Returns a reference to the critical section which is used to sleep the thread.
    function getSleepCS: ISignaledCriticalSection;

    //- Acquire the signaled critical section of the
    //- thread pool to which this thread belongs.
    procedure Acquire;

    //- Release the signaled critical section of the
    //- thread pool to which this thread belongs.
    procedure Release;

    //- Sleep against the signaled critical section of the thread pool to
    //- which this thread belongs.
    procedure Sleep;

    //- Wake threads that are sleeping against the critical section of the thread
    //- pool to which this thread belongs (useful for waking other threads!)
    procedure Wake;

    //- Indicates if this thread is running.
    function IsRunning: boolean;

    //- Returns the state of the terminate flag for the thread (if set the thread should terminate).
    function getTerminateFlag: boolean;

    //- Sets the state of the terminate flag for the thread.
    procedure setTerminateFlag( const value: boolean );

    //- Returns true if the thread should now terminate.
    property TerminateFlag: boolean read getTerminateFlag write setTerminateFlag;
  end;

  //- Manages a pool of long running threads.
  IThreadPool = interface
    ['{7D5DF4B7-69CF-46E3-86B1-02C7CEC1DC06}']

    //- Adds a number of threads to the thread pool, and confirms each of them running.
    procedure AddThreads( const Count: nativeuint; const ThreadExecuteMethod: TThreadExecuteMethod );

    //- Wake threads that are sleeping against the critical section of the thread pool
    procedure Wake;

    //- Returns the number of threads in the pool.
    function getThreadCount: nativeuint;

    //- Terminates all running threads in the thread pool.
    procedure Terminate;

    //- Distributes the thread affinity of the threads over the available
    //- processor cores. This happens in a round-robin, locking each thread
    //- to an available core, then stepping to the next core until rolling over.
    procedure SpreadThreadAffinity;

    ///- Clears the thread affinity back to OS defaults, this can be used to
    //- reverse the above SpreadThreadAffinity call.
    procedure ClearThreadAffinity;
  end;


{$endregion}

{$region ' Types for working with task pooling '}

type
  /// Represents a task within a task-set.
  ITaskRecord = interface
    ['{CBBDA6D6-2304-46E6-905D-F0E015840FEC}']
    //- Executes the task.
    procedure Execute;
    //- Returns true if the task is complete
    function IsComplete: boolean;
    //- Returns true if the task record is locked
    function IsLocked: boolean;
    //- Locks the task record (returns true if successful);
    function Lock: boolean;
  end;

  /// Represents a set of tasks within a task set.
  ITaskSet = interface
    ['{E4957989-BF1F-498E-BC9A-2212553B73E7}']

    // This function finds the next unassigned task in the set, assigns it
    // to the calling thread, and returns it. If this method returns nil
    // there are no remaining tasks in the set which are unassigned. (work
    // may still be proceeding within the assigned tasks, but the calling
    // thread should move on to the next task set to find a task to perform)
    function getNextTask: ITaskRecord;

    /// Returns true when this task set has been completed by the task
    /// threads.
    function IsComplete: boolean;

  end;

  /// Represents a collection of task sets with a critical section to
  /// lock access for insertion and removal of sets.
  ITaskSetCollection = interface
    // Adds a taskset to the collection
    procedure AddTaskSet( const TaskSet: ITaskSet );

    // Returns the next available task from the next available taskset.
    // In returning the taskrecord, that record will become locked such
    // that other threads cannot obtain the same task record.
    // This method will take the opportunity to clean-up any completed
    // task sets before returning a result, and may return nil if there are
    // no remaining tasks to be performed.
    function getNextTask: ITaskRecord;
  end;

  /// <summary>
  ///   Internal representation of a task pool. <br/>
  ///   The task pool performs lock-less scheduling of short running
  ///   tasks.
  /// </summary>
  ITaskPool = interface
    ['{482327E1-94FD-4C6B-A85C-99FB8C489252}']
    {$ifndef fpc}
    procedure AddTaskSet( const Tasks: array of ITask; const WhenDone: TOnComplete ); overload;
    {$else}
    procedure AddTaskSet( const Tasks: array of ITask; const WhenDone: TOnCompleteGlobal ); overload;
    procedure AddTaskSet( const Tasks: array of ITask; const WhenDone: TOnCompleteOfObject ); overload;
    procedure AddTaskSet( const Tasks: array of ITask; const WhenDone: TOnCompleteNested ); overload;
    {$endif}
    procedure AddTaskSet( const Tasks: array of ITask ); overload;
    //- Returns the number of threads in the pool.
    function getThreadCount: nativeuint;
  end;

{$endregion}

{$region ' Hook to clean up long threads on removal'}

  ILongThreadMatcher = interface( IThread )
    ['{A758CC22-B669-40E5-B5F2-0C5483274234}']

    //- If the thread is hosting the LongThread passed in, true is returned.
    function IsMatch(const LongThread: ILongThread): boolean;
  end;

{$endregion}

{$region ' IMessageChannelReader'}
type

  //- Implementations of IMessageChannel also implement IMessageChannelReader.
  //- This is the interface which the thread running a messaged thread will use to read
  //- messages from a message channel.
  IMessageChannelReader = interface
    ['{6E02A182-6384-421E-8546-CBC0FB500F77}']

    //- Returns the ID of the thread which is permitted to send/post to this channel.
    function getPermittedThreadID: TThreadID;

    //- Returns true if there are messages waiting on the channel to be read.
    function getMessagesPending: boolean;

    //- Populates 'Message' with a message from the channel.
    function getNextMessage( out Message: TMessage ): boolean;
  end;

  //- Handles access to long running messaged threads
  IMessagedThreadHandler = interface( IThread )
    ['{EDA65095-1F6B-4548-BF61-D9622A5CD19C}']

    //- Returns the messaged thread that this thread handler is responsible for running.
    function getMessagedThread: IMessagedThread;

    //- If the thread is hosting the messaged thread passed in, true is returned.
    function IsMatch(const MessagedThread: IMessagedThread): boolean;

    //- Returns a message channel for the calling thread to message this one.
    function getMessageChannel: IMessageChannel;
  end;

{$endregion}

implementation

end.

