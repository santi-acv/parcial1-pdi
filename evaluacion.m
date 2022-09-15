% Evaluación
close all
% Leer imágenes de prueba
lena = rgb2gray(imread("lena_color_512.tif"));

densidades = 0.1: 0.1: 0.9;

res_psnr = zeros(length(densidades), 1);
res_ief = zeros(length(densidades), 1);
res_tiempo = zeros(length(densidades), 1);

% Analizar por cada densidad
for i = 1:length(densidades)
    % Obtener densidad
    densidad = densidades(i);
    % Agregar ruido
    lena_ruido = imnoise(lena, "salt & pepper", densidad);
    % Restaurar imagen
    tic
    lena_restaurada = FiltroMedianaAdaptativo(lena_ruido);
    res_tiempo(i) = toc;
    % Guardar figura
    f = figure("Name", "Lena - densidad: " + densidad);
    f.Position(3:4) = [1024 512];
    subplot(1, 3, 1), imshow(lena, 'InitialMagnification', 800)
    subplot(1, 3, 2), imshow(lena_ruido, 'InitialMagnification', 800)
    subplot(1, 3, 3), imshow(lena_restaurada, 'InitialMagnification', 800)
    saveas(f, "resultados/lena_"+densidad+".png")
    % Evaluar

    % PSNR
    [PSNR, snr] = psnr(lena_restaurada, lena);

    % IEF

    IEF = sum( lena_ruido - lena, "all") / sum(lena_restaurada - lena, "all");

    res_psnr(i) = PSNR;
    res_ief(i) = IEF .^ 2;

end


% Exportar resultados en CSV
densidades = transpose(densidades);
resultados = table(densidades, res_psnr, res_ief, res_tiempo);
writetable(resultados, "resultados/lena.csv")