% Callback function for RESUME_SOUND

if start_flag ~= 1,
   blink_load_data;
   return;
end;

resume(player);