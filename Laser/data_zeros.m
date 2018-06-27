 function [x0,freq] = data_zeros(x,y)
      zci = @(v) find(v(:).*circshift(v(:), [-1 0]) <= 0);                    % Returns Approximate Zero-Crossing Indices Of Argument Vector
      dy = zci(y);                                                            % Indices of Approximate Zero-Crossings
      for k1 = 1:size(dy,1)-1
          b = [[1;1] [x(dy(k1)); x(dy(k1)+1)]]\[y(dy(k1)); y(dy(k1)+1)];      % Linear Fit Near Zero-Crossings
          x0(k1) = -b(1)/b(2);                                                % Interpolate ‘Exact’ Zero Crossing
          mb(:,k1) = b;                                                       % Store Parameter Estimates (Optional)
      end
      freq = 1./(2*diff(x0));                                                 % Calculate Frequencies By Cycle
 end
      
% how to call the function 
%x = linspace(0,10*pi,1E+5);                                             % Create Data
%y = sin(1./(x+0.01));                                                   % Create Data
%[xz,frq] = data_zeros(x,y);
%figure(1)
%plot(x, y)
%hold on
%plot(xz, zeros(size(xz)), '+r')
%hold off
%grid
%axis([0  1    ylim])