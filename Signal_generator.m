close all; clc
inputs= inputdlg({'Enter the sampling frequency: ','Enter the start time: ',...
    'Enter the end time: ',...
    'Enter the number of break points: '}, 'Input values');
fs= str2double(inputs(1));
st= str2double(inputs(2));
et= str2double(inputs(3));
nbp= str2double(inputs(4));
bpp=[]; %array for break points positions
power=[]; %array for powers of polynomial
totalTime=[]; %time for operation combined
totalSignal=[]; %for combining all signals together
for i= 1:nbp
    bpp(i)=input(['Enter the position of the break point ' num2str(i) ':']);
end
bpp=[st bpp et];
for j=1:(length(bpp)-1)
    sigType= menu(strcat('Choose signal type for region (',...
                num2str(bpp(j)), ' : ', num2str(bpp(j+1)) ,')'),...
                           'DC Signal', 'Ramp Signal',...
                           'General Order Polynomial Signal',...
                           'Exponential Signal', 'Sinusoidal Signal');
    numsamples = (bpp(j+1)-bpp(j))*fs;
    t = linspace(bpp(j), bpp(j+1), numsamples);
    switch (sigType)
        case 1 %dc signal
            amp = inputdlg('Enter amplitude of DC signal: ','amplitude value');
            amp = str2double(amp); 
            sig = amp*ones(1,numsamples);
        case 2 %Ramp Signal
            inputramp = inputdlg({'Enter slope of Ramp signal: ',...
                             'Enter intercept of Ramp signal: '},'Input values');
            slope = str2double(inputramp(1));
            intercept = str2double(inputramp(2)); 
            sig = slope*t + intercept;
        case 3 %General Order Polynomial Signal
            Highestpower = inputdlg('Enter the Highest power: ','order value');
            Highestpower = str2double(Highestpower);
%             for k = 0:Highestpower
%               powcoeff = inputdlg(strcat('Enter coefficient of X^' num2str(k) ':'));
%               power = [powcoeff power];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
%             end
%             sig = polyval(power,t); % Polynomial evaluation
        case 4 %Exponential Signal
            inputexp = inputdlg({'Enter amplitude of Exponential signal: ',...
                          'Enter exponent of Exponential signal: '},'Input values');
            amp = str2double(inputexp(1));
            exponent = str2double(inputexp(2));
            sig = amp*exp(t*exponent);
        case 5 %"Sinusoidal Signal
            inputsinu = inputdlg({'Enter amplitude of Sinosoidal signal: ',...
                          'Enter freq of Sinosoidal signal: ',...
                          'Enter phase of Sinosoidal signal: '},'Input values');
            amp = str2double(inputsinu(1));
            freq = str2double(inputsinu(2));
            w = 2*pi*freq;
            phase = str2double(inputsinu(3)); 
            sig = amp*sin(w*t + phase);
          otherwise
    end
          totalTime=[totalTime t];
          totalSignal=[totalSignal sig];
end
figure; plot(totalTime, totalSignal);