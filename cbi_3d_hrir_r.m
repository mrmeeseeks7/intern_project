hr_3d = squeeze(hrir_r(Ia,:,(miT:mxT)));              
nup_3d= 4;
npt_up_3d = nup_3d*length(hr_3d);
hrup_3d = (resample(hr_3d',nup_3d,1))';
hr_s_3d = max(max(abs(hrup_3d)));
hr_norm_3d=hrup_3d/hr_s_3d;
Tup_3d = T(miT) + (0:(npt_up_3d-1))*(T(mxT)-T(miT))/(npt_up_3d);

hr3d_han=gca;
surf(hr_norm_3d);

set(hr3d_han,'Tag','3D_HRIR');
grid on;
set(hr3d_han,'FontSize',Fsize);
xlabel('t (ms)');
ylabel('elevation');
zlabel('hrir of right ear');
set(hr3d_han,'yticklabelmode','manual');
set(hr3d_han,'ytick',[1 9 25 41 50]);
set(hr3d_han,'yticklabel',{'-45';'0';'90';'180';'231'});
set(hr3d_han,'xticklabelmode','manual');
set(hr3d_han,'xtick',[38 127 216 305 394]);
set(hr3d_han,'xticklabel',{'0.5';'1';'1.5';'2';'2.5'});
