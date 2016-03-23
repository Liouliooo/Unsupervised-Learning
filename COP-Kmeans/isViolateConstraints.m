function isFail = isViolateConstraints( dataPointIdx, clusterIdx, M, C, K ,clusters )    % Before assign dataPointIdx to clusterIdx, isViolateContraints should be examined.
% Find must-links for data points
if(~isempty(M))
    ML = find(M(: ,1) == dataPointIdx);
    for i = 1 : length(ML)      
        %{
        %% for testing
        for ix = 1 : K
            if(~isempty( find (clusters{ix}.idx == M( ML(i),2))))
                % test = find (clusters{ix}.idx == M( ML(i),2));
                %%%%% fprintf('must-link:%d and cluster: %d\n',M( ML(i),2) ,ix);
            end
        end
        %}
        %%
        if(isempty(find( M( ML(i),2) == clusterIdx) ) )
            isFail = true;                                                  %%% 该算法企图使得，每一个点 dataPoint ,与他所有相连的所有的 must_link 的点在一个类中，
            return ;                                                          %%% 所以，当一个点 dataPoint 有超过两个 must_link 时，而两个must-link的点不在一个类中，算法出错。
        end
    end
end


if(~isempty(M))
    ML_s = find(M(: ,2) == dataPointIdx);
    for i = 1 : length(ML_s)      
        %{
        %% for testing
        for ix = 1 : K
            if(~isempty( find (clusters{ix}.idx == M( ML_s(i),1))))
                %%%%% fprintf('must-link:%d and cluster: %d\n',M( ML_s(i),1) ,ix);
            end
        end
        %}
        if(isempty(find( M( ML_s(i),1) == clusterIdx) ) )
            isFail = true;                                                  
            return ;                                                          
        end
    end
end


% Find cannot-link for data points
if(~isempty(C))
    CL = find(C(: ,1) == dataPointIdx);
    for i = 1 : length(CL)
        %{
        %% for testing
        for ix = 1 : K
            if(~isempty( find (clusters{ix}.idx == C( CL(i),2))))        
                %%%%% fprintf('\tCannot-link:%d and cluster: %d\n',C( CL(i),2) ,ix);
            end
        end
        %}
        %%
        if (~isempty(find( C ( CL(i), 2) == clusterIdx) ) ) %%% 点 dataPoint 有超过27（K） 个cannot-link，如果每个类里都有一个相应的cannot-link，则算法出错。
            isFail = true;
            return ;
        end
    end
end

if(~isempty(C))
    CL = find(C(: ,2) == dataPointIdx);
    for i = 1 : length(CL)
        %{
        %% for testing
        for ix = 1 : K
            if(~isempty( find (clusters{ix}.idx == C( CL(i),1))))        
                %%%%% fprintf('\tCannot-link:%d and cluster: %d\n',C( CL(i),1) ,ix);
            end
        end
        %}
        %%
        if (~isempty(find( C ( CL(i), 1) == clusterIdx) ) ) %%% 点 dataPoint 有超过27（K） 个cannot-link，如果每个类里都有一个相应的cannot-link，则算法出错。
            isFail = true;
            return ;
        end
    end
end




% All constraints satisfied
isFail = false;                                                             %%%　如果dataPoint 有个must-link和cannot-link，但是这个点在一个类中，算法出错。
return;
end
