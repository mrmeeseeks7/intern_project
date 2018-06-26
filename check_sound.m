% Script to check the OS to see if sound output is possible

play_sound_flag = 1;

switch computer,
   
case 'PCWIN64'                            % MS Windows
   if (exist('audioread') ~= 2) && (exist('sound') ~= 2),
      play_sound_flag = 0;
      if show_warning,
         fprintf('\n  I''m sorry, but I could not find either audioplayer.m\n');
         fprintf('  or sound.m on your MATLAB system.\n');
         fprintf('  You can still use the graphics features,\n');
         fprintf('  but the ''play'' actions will be unavailable.\n\n');
         fprintf('Press any key to continue ... ');
         pause;
         fprintf('\n');
      end;
   end;

otherwise
   play_sound_flag = 0;
   if show_warning,
      fprintf('\n  I''m sorry, I do not know how to output sounds\n');
      fprintf(['  on your operating system -- ' computer '.\n']); 
      fprintf('  You can still use the graphics features,\n');
      fprintf('  but the ''play'' actions will be unavailable.\n\n');
      fprintf('  If you know what MATLAB function to call\n');
      fprintf('  to output stereo sound, do the following:\n');
      fprintf('    1.  Edit the case statement in ''check_sound.m''\n');
      fprintf(['        to add the additional case ''' computer '''.\n']);
      fprintf('    2.  Edit the function ''play_sound_array'' to include\n');
      fprintf('        an appropriate call to your sound output function.\n\n');
      fprintf('Press any key to continue ... ');
      pause
      fprintf('\n');
   end;
end;

