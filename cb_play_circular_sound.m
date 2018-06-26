if start_flag ~= 1,
   blink_load_data;
   return;
end;

status_handle = findobj(gcf,'Tag','STATUS');
old_status = get(status_handle,'string');

if exist('player')==1,
    clear player;
end;


Aor=[-80 -65 -55 -45:5:45 55 65 80];
Atemp = [-80 -65 -55 -45:5:45 55 65 80 zeros(1,25)];
for i=1:25,
    Atemp(25+i)=Atemp(26-i);
end;
Atemp=Atemp([13:50 1:12]);

B=zeros(1,length(Atemp));
for i=1:13,
    B(i)=Atemp(i);
end;
for i=14:38,
    B(i)=180-Atemp(i);
end;
for i=39:50,
    B(i)=360+Atemp(i);
end;

[filename, pathname] = uigetfile({'*.wav';'*.ogg';'*.flac';'*.au';'*.mp3';'*.mp4';'*.m4a'},'File Selector');
[Insig, FS]=audioread([pathname filename]);

if FS~=fs,
    Insig=resample(Insig,fs,FS);
end;

if size(Insig,2)>1;
    Insig=squeeze(Insig(:,1));
end;

Az=zeros(length(Insig),1);
n_sam=length(Insig)/360;
orlen=length(Insig);

for i= 2:length(B)-1,
    nl=floor(((B(i)+B(i-1))/2)*n_sam);
    nu=floor(((B(i)+B(i+1))/2)*n_sam);
    Az(nl+1:nu)=B(i);
end;


out_sound=zeros(length(Insig),2);

for i=[2:13 39:49],
    Ia=find(Aor==Atemp(i));
    hl_cir=(squeeze(hrir_l(Ia,9,:)))';
    hr_cir=(squeeze(hrir_r(Ia,9,:)))';
    nl=floor(((B(i)+B(i-1))/2)*n_sam);
    nu=floor(((B(i)+B(i+1))/2)*n_sam);
    Insig_temp=Insig(nl+1:nu);
    Lsig  = length(Insig_temp);             %windowing using hanning function
    [N,L] = size(hl_cir);
    out   = zeros(N*Lsig,2);
    ramp  = ones(size(Insig_temp));
    hann  = hanning(round(.05*fs));
    ramp(1:round(0.025*fs)) = hann(1:round(0.025*fs));
    ramp(end-round(0.025*fs)+1:end) = hann(round(0.025*fs):end);
    Insig_temp = Insig_temp.*ramp;

    if fc < 19000,                     % Low-pass filter the stimulus
        [B,Atemp] = butter(20,fc/(fs/2));
        Insig_temp = filtfilt(B,Atemp,Insig_temp);
    end;

        for i = 1:N,
            out(((i-1)*Lsig+1):(i*Lsig),1) = filter(hl_cir(i,:),1,Insig_temp)';
            out(((i-1)*Lsig+1):(i*Lsig),2) = filter(hr_cir(i,:),1,Insig_temp)';
        end;
    max_val = 1.05*max(max(abs(out)));
    out = out/max_val;
    out_sound(nl+1:nu,:)=out;
end;

clear Ia hl_cir hr_cir Insig_temp Lsig out nu nl N L

for i=14:38,
    Ia=find(Aor==Atemp(i));
    hl_cir=(squeeze(hrir_l(Ia,41,:)))';
    hr_cir=(squeeze(hrir_r(Ia,41,:)))';
    nl=floor(((B(i)+B(i-1))/2)*n_sam);
    nu=floor(((B(i)+B(i+1))/2)*n_sam);
    Insig_temp=Insig(nl+1:nu);
    Lsig  = length(Insig_temp);             %windowing using hanning function
    [N,L] = size(hl_cir);
    out   = zeros(N*Lsig,2);
    ramp  = ones(size(Insig_temp));
    hann  = hanning(round(.05*fs));
    ramp(1:round(0.025*fs)) = hann(1:round(0.025*fs));
    ramp(end-round(0.025*fs)+1:end) = hann(round(0.025*fs):end);
    Insig_temp = Insig_temp.*ramp;

    if fc < 19000,                     % Low-pass filter the stimulus
        [B,Atemp] = butter(20,fc/(fs/2));
        Insig_temp = filtfilt(B,Atemp,Insig_temp);
    end;

        for i = 1:N,
            out(((i-1)*Lsig+1):(i*Lsig),1) = filter(hl_cir(i,:),1,Insig_temp)';
            out(((i-1)*Lsig+1):(i*Lsig),2) = filter(hr_cir(i,:),1,Insig_temp)';
        end;
    max_val = 1.05*max(max(abs(out)));
    out = out/max_val;
    out_sound(nl+1:nu,:)=out;
end;

clear Ia hl_cir hr_cir Insig_temp Lsig out nu nl N L

for i=1,
    Ia=find(Aor==Atemp(i));
    hl_cir=(squeeze(hrir_l(Ia,9,:)))';
    hr_cir=(squeeze(hrir_r(Ia,9,:)))';
    nl=1;
    nu=floor(((B(i)+B(i+1))/2)*n_sam);
    Insig_temp=Insig(nl+1:nu);
    Lsig  = length(Insig_temp);             %windowing using hanning function
    [N,L] = size(hl_cir);
    out   = zeros(N*Lsig,2);
    ramp  = ones(size(Insig_temp));
    hann  = hanning(round(.05*fs));
    ramp(1:round(0.025*fs)) = hann(1:round(0.025*fs));
    ramp(end-round(0.025*fs)+1:end) = hann(round(0.025*fs):end);
    Insig_temp = Insig_temp.*ramp;

    if fc < 19000,                     % Low-pass filter the stimulus
        [B,Atemp] = butter(20,fc/(fs/2));
        Insig_temp = filtfilt(B,Atemp,Insig_temp);
    end;

        for i = 1:N,
            out(((i-1)*Lsig+1):(i*Lsig),1) = filter(hl_cir(i,:),1,Insig_temp)';
            out(((i-1)*Lsig+1):(i*Lsig),2) = filter(hr_cir(i,:),1,Insig_temp)';
        end;
    max_val = 1.05*max(max(abs(out)));
    out = out/max_val;
    out_sound(nl+1:nu,:)=out;
end;

clear Ia hl_cir hr_cir Insig_temp Lsig out nu nl N L

for i=50,
    Ia=find(Aor==Atemp(i));
    hl_cir=(squeeze(hrir_l(Ia,9,:)))';
    hr_cir=(squeeze(hrir_r(Ia,9,:)))';
    nl=floor(((B(i)+B(i-1))/2)*n_sam);
    nu=orlen(end);
    Insig_temp=Insig(nl+1:nu);
    Lsig  = length(Insig_temp);             %windowing using hanning function
    [N,L] = size(hl_cir);
    out   = zeros(N*Lsig,2);
    ramp  = ones(size(Insig_temp));
    hann  = hanning(round(.05*fs));
    ramp(1:round(0.025*fs)) = hann(1:round(0.025*fs));
    ramp(end-round(0.025*fs)+1:end) = hann(round(0.025*fs):end);
    Insig_temp = Insig_temp.*ramp;

    if fc < 19000,                     % Low-pass filter the stimulus
        [B,Atemp] = butter(20,fc/(fs/2));
        Insig_temp = filtfilt(B,Atemp,Insig_temp);
    end;

        for i = 1:N,
            out(((i-1)*Lsig+1):(i*Lsig),1) = filter(hl_cir(i,:),1,Insig_temp)';
            out(((i-1)*Lsig+1):(i*Lsig),2) = filter(hr_cir(i,:),1,Insig_temp)';
        end;
    max_val = 1.05*max(max(abs(out)));
    out = out/max_val;
    out_sound(nl+1:nu,:)=out;
end;

out_sound=sgolayfilt(out_sound,4,13);
player=audioplayer(out_sound,fs);
play(player);