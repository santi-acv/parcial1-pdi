function g = FiltroMedianaAdaptativo(f)
    % Filtro Mediana Adaptativo
    % Implementa el algoritmo propuesto por Srinivasan y Ebenezer (2007).
    [M, N] = size(f);

    % Agrega padding a la matriz de entrada
    f = padarray(f, [1, 1]);

    % Construye la matriz de salida
    g = zeros([M, N], "uint8");

    % Por cada celda de la matriz de salida
    for i = 1:M
        for j = 1:N
            
            % Extrae la ventana
            h = f(i:i+2, j:j+2);
            pixel = h(2,2);

            % Obtenemos los 3 pixeles
            [p_min, p_med, p_max] = obtenerPixeles(h);

            % Determinamos si es un píxel corrupto
            if p_min > 0 && p_max < 255 && p_min < pixel && pixel < p_max
                % No esta corrupto, se deja igual
            else
                % Si esta corrupto, tomamos la mediana si es que no esta
                % corrupta
                if p_min < p_med  && p_med < p_max
                    pixel = p_med;
                else
                    % Tomamos un valor no corrupto del vecindario
                    h = sort(h(:));
                    pixel = h(find(h, 1, "first"));
                    if isempty(pixel)
                        pixel = 0;
                    end
                    % Si todo el vecindario esta corrupto, toma el valor de
                    % la izquierda
                    if (pixel == 255 || pixel == 0) && j > 1
                        pixel = g(i, j-1);
                    end
                end
            end

            % Almacena el resultado
            g(i,j) = pixel;    
        end
    end
end