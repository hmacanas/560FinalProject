function [N1] = getN1(gammaInner, gammaOutter, capOmega)
    col1 = [cos(gammaInner)*cos(gammaOutter);
            cos(gammaInner)*sin(gammaOutter); 
            -sin(gammaInner)];
        
    col2 = [-capOmega*sin(gammaInner)*cos(gammaOutter); 
            -capOmega*sin(gammaInner)*sin(gammaOutter);
            -capOmega*cos(gammaInner)];
    col3 = [-capOmage*cos(gammaInner)*sin(gammaOutter);
            capOmega*cos(gammaInner)*cos(gammaOutter);
            0];
    N1 = [col1 col2 col3];
end

