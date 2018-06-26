hr = squeeze(hrir_r(Ia,Ie,:))';
[AR2d,Fr2d] = freq_resp(hr,Fmin*1000,Fmax*1000,Q,log_scale, NFFT, fs);

hrf_2d_han = gca;

if log_scale,
   semilogx(Fr2d,AR2d,'r');
else
   plot(Fr2d,AR2d,'r');
end;

grid on;
zoom on;
axis([Fr2d(1) Fr2d(end) dBmin dBmax]);
set(hrf_2d_han,'xticklabel',' ');
set(hrf_2d_han,'FontSize',Fsize);
ylabel('Right ear HRTF (dB)');
xlabel('f (kHz)');
