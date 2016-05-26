function [ output_args ] = plotDistribution( x,yMatrix,dname)
ux = unique(x);
label= cell(numel(ux),1);
for ii=1:numel(ux)
    I = find(x(:)==ux(ii));
    x(I) = ii;
    s = sprintf('%d',ux(ii));
    label(ii)=cellstr(s);
end
ux = unique(x);
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    sizeY = size(yMatrix);
    sizeY = sizeY(2);
    P = zeros(numel(ux),sizeY, 2);    
    for ii=1:sizeY
        for jj=ux'
            I = find(x(:)==jj);
            if numel(I) == 1
                P(jj, ii,:) = [yMatrix(I,ii), 0];
            else
                P(jj, ii,:) = mle(yMatrix(I,ii));
            end
        end
    end
    for ii=1:sizeY
        figure;
        plot(x,yMatrix(:,ii),'ob');
        hold on;        
        errorbar(ux,P(ux,ii,1),P(ux,ii,2)*2,'rx');
        title(dname(ii));
        xlabel('APOE types');
        ylabel('Measured value for ROI');
        hold off;
        set(gca, 'XTick',1:numel(ux), 'XTickLabel',label);
    end
    

end

