spectra = importdata("spectra.csv");
lambdaDelta = importdata("lambda_delta.csv");
lambdaStart = importdata("lambda_start.csv");
starNames = importdata("star_names.csv");

lambdaPr = 656.28;
speedOfLight = 299792.458;

nObs = size(spectra, 1);
nStars = size(starNames, 1);
lambdaEnd = lambdaStart + (nObs - 1) * lambdaDelta;
lambda = (lambdaStart : lambdaDelta : lambdaEnd)';

speed = zeros(nStars, 1);

for i = 1:nStars
    s = spectra(:, i);
    [sHa, idx] = min(s);
    lambdaHa = lambda(idx);
    z = (lambdaHa - lambdaPr)/ lambdaPr;
    speed(i) = z * speedOfLight;
end 

movaway = starNames(speed > 0);

figure1 = figure;
hold on

for i = 1:nStars
    s = spectra(:, i);
    if speed(i) > 0
        plot(lambda, s, '-', 'LineWidth', 3);
    else
        plot(lambda, s, '--', 'LineWidth', 1);
    end
end

grid on;
title('Спектры звезд');
xlabel('Длина волны, нм');
ylabel(['Интенсивность, эрг/см^2/с/ ', char(197)]);
legend(starNames, 'Location', 'northeast');
text(lambdaStart + 1, max(max(spectra))*1.05, 'Ильин Вадим, Б01-902');
set(figure1, 'Visible', 'on');
hold off

saveas(figure1, 'spectra.png');
