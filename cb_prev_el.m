% Callback function for PREV_EL button

if start_flag ~= 1,
   blink_load_data;
   return;
end;

if Ie > 1
   Ie = Ie - 1;
   el_handle = findobj(gcf,'Tag','POP_EL');  % Find elevation index
   set(el_handle,'Value',Ie);                % and modify it
   plot_data;
   clear el_wav;                             % Delete sound array
end;
