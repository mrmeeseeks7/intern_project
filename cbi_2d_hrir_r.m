% hr_2d = squeeze(hrir_r(Ia,Ie,(miT:mxT)));              
% nup_2d= 4;
% npt_up_2d = nup_2d*length(hr_2d);
% hrup_2d = (resample(hr_2d',nup_2d,1))';
% hr_s_2d = max(max(abs(hrup_2d)));
% hr_norm_2d=hrup_2d/hr_s_2d;
% Tup_2d = T(miT) + (0:(npt_up_2d-1))*(T(mxT)-T(miT))/(npt_up_2d);
% 
% hr2d_han=gca;
% plot(hr_norm_2d);
% 
% set(hr2d_han,'Tag','3D_HRIR')
% grid on;
% set(hr2d_han,'FontSize',Fsize);
% xlabel('t (ms)');
% ylabel('hrir of left ear');
% set(hr2d_han,'xticklabelmode','manual');
% set(hr2d_han,'xtick',[38 127 216 305 394]);
% set(hr2d_han,'xticklabel',{'0.5';'1';'1.5';'2';'2.5'});

hl_2d = squeeze(hrir_l(Ia,Ie,miT:mxT));
hr_2d = squeeze(hrir_r(Ia,Ie,miT:mxT)); 
nup_2d= 4;
npt_up_2d = nup_2d*length(hl_2d);
hlup_2d = resample(hl_2d',nup_2d,1);
hrup_2d = resample(hr_2d',nup_2d,1);
hl_s_2d = max(max(max(abs(hlup_2d))),max(max(abs(hrup_2d))));
hr_norm_2d=hrup_2d/hl_s_2d;
Tup_2d = T(miT) + (0:(npt_up_2d-1))*(T(mxT)-T(miT))/(npt_up_2d);

hl2d_han=gca;
plot(hr_norm_2d);

set(hl2d_han,'Tag','3D_HRIR');
grid on;
axis([1 396 -1.05 1.05]);
set(hl2d_han,'FontSize',Fsize);
xlabel('t (ms)');
ylabel('hrir of right ear');
set(hl2d_han,'xticklabelmode','manual');
set(hl2d_han,'xtick',[38 127 216 305 394]);
set(hl2d_han,'xticklabel',{'0.5';'1';'1.5';'2';'2.5'});
