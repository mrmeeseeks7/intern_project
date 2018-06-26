hl_3d = squeeze(hrir_l(Ia,:,(miT:mxT)));              
nup_3d= 4;
npt_up_3d = nup_3d*length(hl_3d);
hlup_3d = (resample(hl_3d',nup_3d,1))';
hl_s_3d = max(max(abs(hlup_3d)));
hl_norm_3d=hlup_3d/hl_s_3d;
Tup_3d = T(miT) + (0:(npt_up_3d-1))*(T(mxT)-T(miT))/(npt_up_3d);

hl3d_han=gca;
surf(hl_norm_3d);

set(hl3d_han,'Tag','3D_HRIR')
grid on;
set(hl3d_han,'FontSize',Fsize);
xlabel('t (ms)');
ylabel('elevation');
zlabel('hrir of left ear');
set(hl3d_han,'yticklabelmode','manual');
set(hl3d_han,'ytick',[1 9 25 41 50]);
set(hl3d_han,'yticklabel',{'-45';'0';'90';'180';'231'});
set(hl3d_han,'xticklabelmode','manual');
set(hl3d_han,'xtick',[38 127 216 305 394]);
set(hl3d_han,'xticklabel',{'0.5';'1';'1.5';'2';'2.5'});
