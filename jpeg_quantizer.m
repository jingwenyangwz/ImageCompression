function [quantized_values] = jpeg_quantizer(dct_coeffs, lumi_chromi, QF)
    
    lumi_table = [  16 11 10 16 24 40 51 61; ...
                    12 12 14 19 26 58 60 55; ...
                    14 13 16 24 40 57 69 56; ...
                    14 17 22 29 51 87 80 62; ...
                    18 22 37 56 68 109 103 77; ...
                    24 35 55 64 81 104 113 92; ...
                    49 64 78 87 103 121 120 101; ...
                    72 92 95 98 112 100 103 99];
    
    chromi_table = [17 18 24 47 99 99 99 99; ...
                    18 21 26 66 99 99 99 99; ...
                    24 26 56 99 99 99 99 99; ...
                    47 66 99 99 99 99 99 99; ...
                    99 99 99 99 99 99 99 99; ...
                    99 99 99 99 99 99 99 99; ...
                    99 99 99 99 99 99 99 99; ...
                    99 99 99 99 99 99 99 99];
     N1 = size(dct_coeffs,1);
     N2 = size(dct_coeffs,2);
     
     T1 = size(lumi_table,1);
     T2 = size(lumi_table,2);
     
     ratio1 = T1/N1;
     ratio2 = T2/N2;
     
     
     if lumi_chromi == 1
         quantized_values = round(dct_coeffs./(QF*lumi_table(1:ratio1:end,1:ratio2:end)));
     elseif lumi_chromi == 2 
          quantized_values = round(dct_coeffs./(QF*chromi_table(1:ratio1:end,1:ratio2:end)));
     end
     
end
