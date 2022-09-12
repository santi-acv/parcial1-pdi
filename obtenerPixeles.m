function [p_min,p_med, p_max] = obtenerPixeles(vecindad)
%   Obtiene el píxel menor, la mediana y el píxel mayor
p_min = min(vecindad, [], 'all');
p_med = median(vecindad, 'all');
p_max = max(vecindad, [], 'all');
end