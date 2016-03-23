function [must_link,cannot_link] = buildContraints(p_idx)

numM = 200;
numC = 200;

% n is the columns of p_idx.
[~, n] = size(p_idx);

must_link = [ ];
cannot_link = [ ];

%%  must-link
j=1;
while (j <= numM)
    % Randomly choose a number, remember its index.
    m_to_link = randi(n);
    classToLink = p_idx(m_to_link);
    
   % Choose another number to must_link.
    classIdx = find( p_idx == classToLink);
    toLink = classIdx( randperm(length(classIdx),1));
    
    % If the two must_link number are the same, continue.
    if (m_to_link == toLink)
        continue;
    end
    
    must_link = [must_link ;[ m_to_link, toLink] ];
    j=j+1;
end

%%  cannot-link
i = 1;
while (i <=numC)
    % Randomly choose a number.
    c_not_link = randi(n);      % real number to link, in cannot link.
    c_not_index = p_idx(c_not_link);     % index
    
    %classNotLink = uniqueLabels(randperm( length(unique(p_idx)), 2) );
    not_link = randi(n);
    not_link_index = p_idx(not_link);
    
    % If the two number are from on class, continue.
    if (c_not_index == not_link_index)
        continue;
    end

    i = i+1;
    cannot_link = [cannot_link; [c_not_link, not_link ] ];
end
