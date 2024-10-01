% which data to calculate ?
 plane = [2,2,0];
% 220
% 4-20
% 306
% 30-6
% 300

 sample = 'W6725';
% W6723
% W6725

%% ----- experimental values -----
% (220) 
if plane == [2,2,0]
    if strcmp(sample,'W6723')
        q_sub_exp = [4.206 ; 7.282]; % 1/nm
        q_film_exp = [4.058 ; 6.956]; % 1/nm
    elseif strcmp(sample,'W6725')
        q_sub_exp = [4.219 ; 7.234];
        q_film_exp = [4.059 ; 6.916];

        % This Data comes from the (4-20)-files but is analyzed here, since
        % it has positive inplane component
    end
end
% (4-20)
if plane == [4,-2,0]
    if strcmp(sample,'W6723')
        % measurement failed
        %
    elseif strcmp(sample,'W6725')
        q_sub_exp = [-4.192 ; 7.291];
        q_film_exp = [-4.039 ; 6.932];

        % This Data comes from the (220)-files but is analyzed here, since
        % it has negative inplane component
    end
end
% (306) 
if plane == [3,0,6]
    if strcmp(sample,'W6723')
        q_sub_exp = [4.206 ; 7.286];
        q_film_exp = [4.064 ; 6.955];
    elseif strcmp(sample,'W6725')
        q_sub_exp = [4.601 ; 7.294];
        q_film_exp = [4.385 ; 6.977];
    end
end
% (30-6)
if plane == [3,0,-6]
    if strcmp(sample,'W6723')
        q_sub_exp = [-4.205 ; 7.284];
        q_film_exp = [-4.051 ; 6.956];
    elseif strcmp(sample,'W6725')
        q_sub_exp = [-4.638 ; 7.271];
        q_film_exp = [-4.529 ; 6.875];
    end
end
% (300)
if plane == [3,0,0]
    if strcmp(sample,'W6725')
        q_sub_exp = [-0.017 ; 7.283];
        q_film_exp = [-0.091 ; 6.923];
    elseif strcmp(sample,'W6723')
        q_sub_exp = [-0.000 ; 7.284];
        q_film_exp = [-0.000 ; 6.959];
    end
end

% Literature Values
al2o3_a = 4.759 / 10; % nm
al2o3_c = 12.993 / 10; % nm

cr2o3_a = 4.958 / 10; % nm
cr2o3_c = 13.593 / 10; % nm

%% ----- formulas for reciprocal space vectors -----
% inverse lattice plane distance := qx or qy 
qi = @(hkl,a,c) sqrt(...
    4/3*(hkl(1)^2+hkl(2)^2+hkl(1)*hkl(2))/a^2 + ...
    hkl(3)^2/c^2);

R = @(gamma) [cos(gamma),-sin(gamma);sin(gamma),cos(gamma)];
    % rotation matrix in general for rotation of RSM
crossProduct = @(x,y) x(1)*y(2)-x(2)*y(1);
    % needed for handedness of rotation


% (220) <--> (2-10) + (030)
if plane == [2,2,0]
    q_sub_lit = [qi([2,-1,0],al2o3_a,al2o3_c) ; qi([0,3,0],al2o3_a,al2o3_c)]; % 1/nm
    q_film_lit = [qi([2,-1,0],cr2o3_a,cr2o3_c) ; qi([0,3,0],cr2o3_a,cr2o3_c)]; % 1/nm
end
% (4-20) <--> (110) + (3-30)
if plane == [4,-2,0]
    q_sub_lit = [-1 * qi([1,1,0],al2o3_a,al2o3_c) ; qi([3,-3,0],al2o3_a,al2o3_c)]; % 1/nm
    q_film_lit = [-1 * qi([1,1,0],cr2o3_a,cr2o3_c) ; qi([3,-3,0],cr2o3_a,cr2o3_c)]; % 1/nm
end
% (306) <--> (006) + (300)
if plane == [3,0,6]
    q_sub_lit = [qi([0,0,6],al2o3_a,al2o3_c) ; qi([3,0,0],al2o3_a,al2o3_c)]; % 1/nm
    q_film_lit = [qi([0,0,6],cr2o3_a,cr2o3_c) ; qi([3,0,0],cr2o3_a,cr2o3_c)]; % 1/nm
end
% (30-6) <--> (00-6) + (300)
if plane == [3,0,-6]
    q_sub_lit = [-1*qi([0,0,-6],al2o3_a,al2o3_c) ; qi([3,0,0],al2o3_a,al2o3_c)]; % 1/nm
    q_film_lit = [-1 * qi([0,0,-6],cr2o3_a,cr2o3_c) ; qi([3,0,0],cr2o3_a,cr2o3_c)]; % 1/nm
end
% (300) <--> (000) + (300)
if plane == [3,0,0]
    q_sub_lit = [qi([0,0,0],al2o3_a,al2o3_c) ; qi([3,0,0],al2o3_a,al2o3_c)]; % 1/nm
    q_film_lit = [qi([0,0,0],cr2o3_a,cr2o3_c) ; qi([3,0,0],cr2o3_a,cr2o3_c)]; % 1/nm
end
%% correction calculation
rho = norm(q_sub_lit)/norm(q_sub_exp);
    % distortion of RSM
gamma = acos( ...
    dot(q_sub_lit,q_sub_exp) / ...
    (norm(q_sub_lit)*norm(q_sub_exp)) ...
    );
    % rotation of RSM
drehsinn = sign(crossProduct(q_sub_exp,q_sub_lit));
    % direction of rotation of RSM
correctionMatrix = rho * R(gamma * drehsinn);
    % matrix for transforming vectors in 2-d space

disp(string(plane(1))+","+string(plane(2))+","+string(plane(3))+" --- "+string(sample))
disp("Stretch: "+string(rho)+"; rotate: "+string(gamma*drehsinn)+" ("+string(gamma*drehsinn*180/(pi))+"°)");

% ---- #### ---- correction of film values
q_film_cor = correctionMatrix * q_film_exp;
% ---- #### ----

%% Output Lattice constants
% (220) peak -> (2-10) inplane; (030) outplane
if plane == [2,2,0]
    a_ip = 2 / q_film_cor(1);
    a_op = sqrt(12) / q_film_cor(2);
end
% (4-20) peak -> (110) inplane + (3-30) outplane
if plane == [4,-2,0]
    a_ip = -2 / q_film_cor(1);
    a_op = sqrt(12) / q_film_cor(2);
end
% (306) peak -> (006) inplane; (300) outplane
if plane == [3,0,6]
    c_ip = 6 / q_film_cor(1);
    a_op = sqrt(12) / q_film_cor(2);
end
% (30-6) peak -> (00-6) inplane; (300) outplane
if plane == [3,0,-6]
    c_ip = -6 / q_film_cor(1);
    a_op = sqrt(12) / q_film_cor(2);
end
% (300)
if plane == [3,0,0]
    a_op = sqrt(12) / q_film_cor(2);
end