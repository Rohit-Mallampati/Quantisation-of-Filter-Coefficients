function [A1,dec2bina,er] = Quant(a,Bits,In,Fr)

In1 = In-1;
NegLim = -(2^(In1));
PosLim = ((2^(In1)) - (2^(-Fr)));  % limits described in Lecture 7 pg: 16

A1 = []; % output array 

for i = 1:length(a)
    if a(i) < 0
        if a(i) <= NegLim
            bina2dec = NegLim;
        elseif 0 > a(i) > NegLim % loop for negative coefficients
            temp = abs(a(i)); % converting to positive 
            dec2bina = fix(rem(temp*pow2(-(In-1):Fr),2)); % converting decimal to binary 
            % sign magnitude function starts
            negadd = [1];
            negadd = [negadd, zeros(1, length(dec2bina) - length(negadd))];
            %flipadd = fliplr(negadd);
            magsig = fliplr(de2bi(bi2de(fliplr(dec2bina))+bi2de(fliplr(negadd)))); % binary addition for sign magnitude representation
            % the binary to decimal conversion
            onl1 = magsig(2:Bits); % setting first digit to sign representation
            bina2dec = -1*onl1*pow2(In1-1:-1:-Fr).';
        end
    elseif a(i) > PosLim % loop for positive coefficients
        bina2dec = PosLim;
    else
        dec2bina = fix(rem(a(i)*pow2(-(In-1):Fr),2));
        onl2 = dec2bina(2:Bits);
        if dec2bina(1) == 1
            bina2dec = -1*onl2*pow2(In1-1:-1:-Fr).';
        else
            bina2dec = onl2*pow2(In1-1:-1:-Fr).';
        end
    end
    A1(i) = bina2dec;
    er = ((abs(a - bina2dec))*100);
end
end