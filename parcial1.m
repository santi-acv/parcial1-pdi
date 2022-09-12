f = imread('barbara.bmp');

if size(f,3) == 3
    f = rgb2gray(f);
end

g = FiltroMedianaAdaptativo(f);

imshow(f), figure, imshow(g);

function g = FiltroMedianaAdaptativo(f)
    % Filtro Mediana Adaptativo
    % Implementa el algoritmo propuesto por Srinivasan y Ebenezer (2007).

    % Agrega padding a la matriz de entrada
    f = padarray(f, [1, 1]);

    % Construye la matriz de salida
    g = zeros([M, N], "uint8");

    % Por cada celda de la matriz de salida
    for i = 1:M
        for j = 1:N
            
            % Extrae la ventana
            h = f(i:i+2, j:j+2);
            
            % TODO Implementa el algoritmo propuesto

            % TODO Almacena el resultado
            g(i,j) = h(2,2);    
        end
    end
end
