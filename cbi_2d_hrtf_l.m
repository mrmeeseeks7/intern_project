hl = squeeze(hrir_l(Ia,Ie,:))';
[AL2d,Fr2d] = freq_resp(hl,Fmin*1000,Fmax*1000,Q,log_scale, NFFT, fs);

hlf_2d_han = gca;

if log_scale,
   semilogx(Fr2d,AL2d,'r');
else
   plot(Fr2d,AL2d,'r');
end;

grid on;
zoom on;
axis([Fr2d(1) Fr2d(end) dBmin dBmax]);
set(hlf_2d_han,'xticklabel',' ');
set(hlf_2d_han,'FontSize',Fsize);
ylabel('Left ear HRTF (dB)');
xlabel('f (kHz)');
