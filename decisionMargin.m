% plot decision boundries of a Bayes classifier with Gaussian class densities
% and a diagonal and equal (i.e between classes) covariance matrix
% Written by Itamar Katz, 2012
% modified by Sam on 1st, Aug, 2017 in Technion
    % should able to deal the below with both hand-script and matlab

% preparation for ploting convience i.e. plot-boundaries
lim = 25;
[X, Y] = meshgrid(linspace(-lim,lim,100),linspace(-lim,lim,100));

% prior probability vector of classes, i.e. p(w_i)
w = [0 0 0];  % sum up to 100%
w(1) = 0;
w(2) = 1- 0.5*w(1);
w(3) = w(2)
miu1 = [0, 2];
miu2 = [-1.73, -1];
miu3 = [1.73, -1];

% assume a diagonal covarianvce matrix
sigmaInv1 = 1 ./ [.5 .5]; 
sigmaInv2 = 1 ./ [0.5 0.5];
sigmaInv3 = 1 ./ [.5 .5];
% posterior probabilities based on bayesian classification
  % p(w_1|x) = p(x|w_1) * p(w_1) * 1/ SUM( p(x| w_j) * p(w_j) )
        % since the denominator are the same( normalization factor), it's
        % safe to cancel them out simultaneously
    % + understand bayesian rule with the help of Zhihu.com
        % likelihood: prior --likelihood--> posteriror
            % we change our attitute with newly-imported news
            % denominator( normalizaiton factor --> parallel universe)
g1 = w(1) *  exp(-sigmaInv1(1)*(X-miu1(1)).^2-sigmaInv1(2)*(Y-miu1(2)).^2);
g2 = w(2) *  exp(-sigmaInv2(1)*(X-miu2(1)).^2-sigmaInv2(2)*(Y-miu2(2)).^2);
g3 = w(3) *  exp(-sigmaInv3(1)*(X-miu3(1)).^2-sigmaInv3(2)*(Y-miu3(2)).^2);
% statistic stuff done

% Plotting session 
    % contour of 3-classes
f1=figure;
hold on
contour (X,Y,(g1),20)
contour (X,Y,(g2),20)
contour (X,Y,(g3),20)
axis equal;axis square
xlim([-lim lim]);ylim([-lim lim]);
grid
title('posterior densities')

f2=figure;
imagesc([-lim lim],[-lim,lim],1 * (g1 >= g2 & g1 > g3) + 2 * (g3 >= g2 & g3 >= g1))
axis xy;axis equal;axis square
xlim([-lim lim]);ylim([-lim lim]);
title('opt-bayes decision boundries')
figure(f1)