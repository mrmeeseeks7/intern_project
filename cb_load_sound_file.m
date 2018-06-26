% Callback function for LOAD_FILE

if start_flag ~= 1,
   blink_load_data;
   return;
end;

status_handle = findobj(gcf,'Tag','STATUS');
old_status = get(status_handle,'string');

if exist('player')==1,
    clear player;
end;

[filename, pathname] = uigetfile({'*.wav';'*.ogg';'*.flac';'*.au';'*.mp3';'*.mp4';'*.m4a'},'File Selector');
[Insig, FS]=audioread([pathname filename]);

if FS~=fs,
    Insig=resample(Insig,fs,FS);
end;

if size(Insig,2)>1;
    Insig=squeeze(Insig(:,1));
end;
Insig=Insig';

hl = (squeeze(hrir_l(Ia,Ie,:)))';
hr = (squeeze(hrir_r(Ia,Ie,:)))';
fc=20000;

Lsig  = length(Insig);             %windowing using hanning function
out   = zeros(Lsig,2);
ramp  = ones(size(Insig));
hann  = hanning(round(.05*fs));
ramp(1:round(0.025*fs)) = hann(1:round(0.025*fs));
ramp(end-round(0.025*fs)+1:end) = hann(round(0.025*fs):end);
Insig = Insig.*ramp;

if fc < 19000,                     % Low-pass filter the stimulus
   [B,A] = butter(20,fc/(fs/2));
   Insig = filtfilt(B,A,Insig);
end;


out(1:Lsig,1) = filter(hl(1,:),1,Insig)';
out(1:Lsig,2) = filter(hr(1,:),1,Insig)';


max_val = 1.05*max(max(abs(out)));
out = out/max_val;                 % scale

player=audioplayer(out,fs);
play(player);

set(status_handle,'string',old_status);
