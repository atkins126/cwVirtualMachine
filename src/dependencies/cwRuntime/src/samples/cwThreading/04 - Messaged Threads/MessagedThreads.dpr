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
program MessagedThreads;
uses
  sysutils // for sleep()
, cwThreading
, cwThreading.Standard
;

const
  MSG_VIDEO_RES      = $0001;
  MSG_VIDEO_REFRESH  = $0002;

const
  MSG_AUDIO_VOL_UP   = $0001;
  MSG_AUDIO_VOL_DOWN = $0002;
  MSG_AUDIO_PLAY     = $0003;

type
  TAudioSubSystem = class( TInterfacedObject, IMessagedThread )
  strict private
    procedure HandleMessage( const Message: TMessage );
  end;

  TVideoSubSystem = class( TInterfacedObject, IMessagedThread )
  strict private
    procedure HandleMessage( const Message: TMessage );
  end;

procedure TVideoSubSystem.HandleMessage(const Message: TMessage);
begin
  case Message.Value of
    MSG_VIDEO_RES: Writeln('Adjusting video resolution. (No actual change)');
    MSG_VIDEO_REFRESH: Writeln('Adjusting video refresh rate. (No actual change)');
  end;
end;

procedure TAudioSubSystem.HandleMessage(const Message: TMessage);
begin
  case Message.Value of
    MSG_AUDIO_VOL_UP: Writeln('Audio volume increased. (No actual change)');
    MSG_AUDIO_VOL_DOWN: Writeln('Audio volume decreased. (No actual change)');
    MSG_AUDIO_PLAY: Writeln('Playing sample. (Nothing actually playing).');
  end;
end;

var
  aStr: string;
  CH: char;
  AudioChannel: IMessageChannel;
  VideoChannel: IMessageChannel;

begin
  //- Create threads which may be sent messages.
  ThreadSystem.Execute('audio',TAudioSubSystem.Create());
  ThreadSystem.Execute('video',TVideoSubSystem.Create());

  //- Get message channels for main thread to send messages on.
  //- Note: These channels are for the exclusive use of the main thread,
  //- other threads would need to acquire their own channels.
  AudioChannel := ThreadSystem.getMessageChannel('audio');
  VideoChannel := ThreadSystem.getMessageChannel('video');

  //- Now lets give the user a menu and start sending messages to our threads.
  repeat
    Writeln('Select from the following options: ');
    Writeln('       u/U: Increase audio volume.');
    Writeln('       d/D: Decrease audio volume.');
    Writeln('       p/P: Play audio sample.');
    Writeln('       r/R: Adjust video resolution.');
    Writeln('       h/H: Adjust video refresh Hz.');
    Writeln('       x/X: To exit the program.');
    Writeln;

    Write('>');
    Readln(aStr);
    CH := aStr[1];
    case ch of
      'u','U': AudioChannel.PostMessage( TMessage.Create( MSG_AUDIO_VOL_UP, 0, 0, 0, 0   ));
      'd','D': AudioChannel.PostMessage( TMessage.Create( MSG_AUDIO_VOL_DOWN, 0, 0 ,0 ,0 ));
      'p','P': AudioChannel.PostMessage( TMessage.Create( MSG_AUDIO_PLAY    ));
      'r','R': VideoChannel.PostMessage( TMessage.Create( MSG_VIDEO_RES     ));
      'h','H': VideoChannel.PostMessage( TMessage.Create( MSG_VIDEO_REFRESH ));
      'x','X': break;
    end;
    Sleep(500);
    Writeln;
    Writeln;
    Writeln;
  until False;
end.

