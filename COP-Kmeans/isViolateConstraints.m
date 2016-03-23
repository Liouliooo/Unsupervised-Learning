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
            isFail = true;                                                  %%% ���㷨��ͼʹ�ã�ÿһ���� dataPoint ,�����������������е� must_link �ĵ���һ�����У�
            return ;                                                          %%% ���ԣ���һ���� dataPoint �г������� must_link ʱ��������must-link�ĵ㲻��һ�����У��㷨����
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
        if (~isempty(find( C ( CL(i), 2) == clusterIdx) ) ) %%% �� dataPoint �г���27��K�� ��cannot-link�����ÿ�����ﶼ��һ����Ӧ��cannot-link�����㷨����
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
        if (~isempty(find( C ( CL(i), 1) == clusterIdx) ) ) %%% �� dataPoint �г���27��K�� ��cannot-link�����ÿ�����ﶼ��һ����Ӧ��cannot-link�����㷨����
            isFail = true;
            return ;
        end
    end
end




% All constraints satisfied
isFail = false;                                                             %%%�����dataPoint �и�must-link��cannot-link�������������һ�����У��㷨����
return;
end
