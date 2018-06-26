duration = 2;
toffset = 0.2;
kshift = 10;
up_factor = 4;
num_els = size(hrir_l,2);
num_times = size(hrir_l,3);
times = ((1:num_times)-1)*1000/fs;

% EXTRACT AND INTERPOLATE HORIZONTAL-PLANE DATA

azimuths = [-80 -65 -55 -45:5:45 55 65 80];
elevations = -45:360/64:235;
el_0 = 9;
el_180 = 41;

hl_0 = squeeze(hrir_l(:,el_0,:))';    % Build the left horizontal hrir array
hl_180 = squeeze(hrir_l(:,el_180,:))';
hl = zeros(num_times, 50);
hl(:,1:13) = hl_0(:,13:25);
hl(:,14:38)= hl_180(:,end:-1:1);
hl(:,39:51) = hl_0(:,1:13);
hazs = [0:5:45 55 65 80];
szah = hazs(end:-1:1);
hazimuths = [hazs, 180-szah, 180+hazs(2:end), 360-szah];
hazimuths_int = [0:5:360];
debug = 0;
[hl_int, shiftl_int] = interp_hrir(hl, hazimuths, hazimuths_int, debug);
hl_norm = 0.99*hl_int./max(max(abs(hl_int)));
hl_norm=hl_norm';
tmin = min(shiftl_int)*(1000/fs)+toffset;
tmax = tmin+duration;
ktmin = min(find(times >= tmin));
ktmax = max(find(times <= tmax));
ktrange = (ktmin:ktmax)-kshift;

gca;                            % Activate axes

surf( times(ktrange)-times(ktmin), hazimuths_int,hl_norm(:,ktrange));
ylabel('Azimuth(deg)','fontsize',Fsize);
xlabel('Time (ms)','fontsize',Fsize);
zlabel('HRIR of left ear');
zoom on;

