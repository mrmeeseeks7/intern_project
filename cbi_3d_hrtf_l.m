hl_3d = (squeeze(hrir_l(Ia,:,(miT:mxT))))';

if do_smooth, Q = 8; else Q = Inf; end;
[AL_3d,Fr_3d] = freq_resp(hl_3d,Fmin*1000,Fmax*1000,Q,log_scale, NFFT, fs);
LF_3d = length(Fr_3d);
AL_3d=AL_3d';

hlf_3d_han=gca;
surf(AL_3d);

set(hlf_3d_han,'Tag','3D_HRTF')
grid on;
set(hlf_3d_han,'FontSize',Fsize);
ylabel('Elevation (deg)','fontsize',Fsize);
xlabel('Frequency (kHz)','fontsize',Fsize);
zlabel('Left ear HRTF(dB)');
set(hlf_3d_han,'yticklabelmode','manual');
set(hlf_3d_han,'ytick',[0 9 25 41 50]);
set(hlf_3d_han,'yticklabel',{'-45';'0';'90';'180';'231'});
if log_scale,
   plot_freqs = [.0625 .125 .250 .5  1  2  4  8  16];
   xticklabels = {'0.0625';'0.125';'0.25';'0.5';'1';'2';'4';'8';'16'};
   [junk, kkmin] = max(plot_freqs-Fmin>0);
   if Fmax >= plot_freqs(end),
      kkmax = length(plot_freqs);
   else
      [junk, kkmax] = max(plot_freqs-Fmax>0);
      kkmax = kkmax-1;
   end;
   plot_freqs = plot_freqs(kkmin:kkmax);
   xticks = (Fmin+((Fmax-Fmin)/log10(Fmax/Fmin))*log10(plot_freqs/Fmin)')*5;
   xticklabels=xticklabels(kkmin:kkmax);
   set(hlf_3d_han,'xticklabelmode','manual');
   set(hlf_3d_han,'xtick',xticks);
   set(hlf_3d_han,'xticklabel',xticklabels);
end;