#set document(title: "Exercise Session 5 — Solutions")
#set page(margin: 2.5cm, numbering: "1")
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)

#show math.equation: set text(size: 11pt)

#align(center)[
  #text(16pt, weight: "bold")[Exercise Session 5 — Solutions]
  #v(0.3em)
  #text(11pt, style: "italic")[Return by 15/4/26]
]

#v(1em)
#line(length: 100%, stroke: 0.5pt)
#v(1em)

= Exercise 5.1 — Bayesian Estimation of Variance for PM2.5 Concentrations

The observed data are $n = 20$ measurements with known mean $mu = 40$ µg/m³:

#align(center)[
  #table(
    columns: 10,
    stroke: 0.4pt,
    inset: 5pt,
    [35],[42],[38],[40],[37],[45],[39],[41],[36],[44],
    [43],[38],[40],[39],[42],[41],[37],[36],[43],[40],
  )
]

#v(0.5em)

== Part (a): Conjugate Prior Family for the Variance

When the mean $mu$ is *known* and the data are normally distributed, we want a conjugate prior for the variance $theta = sigma^2$ (not the precision).

The likelihood for a single observation is:

$
p(y_i | theta) = (2 pi theta)^(-1/2) exp lr(( -frac((y_i - mu)^2, 2 theta) ))
$

The full likelihood is:

$
p(bold(y) | theta) prop theta^(-n/2) exp lr(( -frac(1, 2 theta) sum_(i=1)^n (y_i - mu)^2 ))
$

This has the kernel of an *Inverse-Gamma* distribution in $theta$. Therefore, the conjugate family of prior distributions for $theta = sigma^2$ when $mu$ is known is the *Inverse-Gamma family*:

$
theta approx "IG"(alpha, beta), quad p(theta) prop theta^(-(alpha+1)) exp lr(( -frac(beta, theta) )), quad theta > 0
$

with shape parameter $alpha > 0$ and scale parameter $beta > 0$.

#v(0.5em)

== Part (b): Prior Parameters from Moment Matching

For $theta approx "IG"(alpha, beta)$, the mean and variance are:

$
bb(E)[theta] = frac(beta, alpha - 1) quad (alpha > 1), quad "Var"(theta) = frac(beta^2, (alpha-1)^2 (alpha - 2)) quad (alpha > 2)
$

We are given $bb(E)[theta] = 16$ and $"Var"(theta) = 8$. Setting up the system of equations:

$
frac(beta, alpha - 1) = 16 quad => quad beta = 16(alpha - 1)
$

$
frac(beta^2, (alpha-1)^2(alpha-2)) = 8 quad => quad frac(16^2(alpha-1)^2, (alpha-1)^2(alpha-2)) = 8 quad => quad frac(256, alpha - 2) = 8
$

Solving:

$
alpha - 2 = frac(256, 8) = 32 quad => quad alpha = 34
$

$
beta = 16(34 - 1) = 16 times 33 = 528
$

The prior is $theta approx "IG"(34, 528)$.

#v(0.5em)

== Part (c): Posterior Distribution

The sufficient statistic from the data is:

$
S = sum_(i=1)^n (y_i - mu)^2 = sum_(i=1)^20 (y_i - 40)^2
$

Computing $S$ from the data:

#align(center)[
  #table(
    columns: 5,
    stroke: 0.4pt,
    inset: 5pt,
    align: center,
    table.header([$y_i$], [$y_i - 40$], [$(y_i - 40)^2$], [$y_i$], [$(y_i - 40)^2$]),
    [35],[$-5$],[25],[43],[9],
    [42],[2],[4],[38],[4],
    [38],[$-2$],[4],[40],[0],
    [40],[0],[0],[39],[1],
    [37],[$-3$],[9],[42],[4],
    [45],[5],[25],[41],[1],
    [39],[$-1$],[1],[37],[9],
    [41],[1],[1],[36],[16],
    [36],[$-4$],[16],[43],[9],
    [44],[4],[16],[40],[0],
  )
]

$
S = 25 + 4 + 4 + 0 + 9 + 25 + 1 + 1 + 16 + 16 + 9 + 4 + 0 + 1 + 4 + 1 + 9 + 16 + 9 + 0 = 154
$

The posterior combines the likelihood and the prior:

$
p(theta | bold(y)) prop p(bold(y) | theta) \u{22C5} p(theta)
$

$
prop theta^(-n/2) exp lr(( -frac(S, 2theta) )) \u{22C5} theta^(-(alpha+1)) exp lr(( -frac(beta, theta) ))
$

$
prop theta^(-(alpha + n/2 + 1)) exp lr(( -frac(beta + S/2, theta) ))
$

This is the kernel of an $"IG"(alpha^*, beta^*)$ distribution. Therefore:

$
theta | bold(y) approx "IG"(alpha^*, beta^*)
$

with:

$
alpha^* = alpha + frac(n, 2) = 34 + frac(20, 2) = 34 + 10 = 44
$

$
beta^* = beta + frac(S, 2) = 528 + frac(154, 2) = 528 + 77 = 605
$

#v(0.5em)

== Part (d): Posterior Mean and Variance

Using the formulas for the Inverse-Gamma distribution with parameters $alpha^* = 44$ and $beta^* = 605$:

*Posterior Mean:*

$
bb(E)[theta | bold(y)] = frac(beta^*, alpha^* - 1) = frac(605, 43) approx 14.07
$

*Posterior Variance:*

$
"Var"(theta | bold(y)) = frac((beta^*)^2, (alpha^* - 1)^2 (alpha^* - 2)) = frac(605^2, 43^2 times 42) = frac(366025, 77658) approx 4.71
$

#v(1em)
#line(length: 100%, stroke: 0.5pt)
#v(1em)

= Exercise 5.2 — Bayesian Linear Regression: PM2.5 and Blood Pressure

The dataset ($n = 12$):

#align(center)[
  #table(
    columns: 13,
    stroke: 0.4pt,
    inset: 5pt,
    align: center,
    table.header([$X_i$ (PM2.5)],[10],[12],[15],[18],[20],[22],[25],[28],[30],[32],[35],[38]),
    [$Y_i$ (SBP)],[110],[112],[115],[120],[123],[125],[130],[135],[138],[140],[145],[150],
  )
]

The model is $Y_i | beta_0, beta_1, sigma^2 approx cal(N)(beta_0 + beta_1 X_i, sigma^2)$.

#v(0.5em)

== Part (a): Likelihood Function

The observations are conditionally independent, so the likelihood is:

$
p(bold(y) | beta_0, beta_1, sigma^2) = product_(i=1)^n frac(1, sqrt(2 pi sigma^2)) exp lr(( -frac((y_i - beta_0 - beta_1 x_i)^2, 2sigma^2) ))
$

$
= (2 pi sigma^2)^(-n/2) exp lr(( -frac(1, 2sigma^2) sum_(i=1)^n (y_i - beta_0 - beta_1 x_i)^2 ))
$

In matrix form, letting $bold(y) in bb(R)^n$, $bold(X) in bb(R)^(n times 2)$ with rows $(1, x_i)$, and $bold(beta) = (beta_0, beta_1)^T$:

$
p(bold(y) | bold(beta), sigma^2) = (2 pi sigma^2)^(-n/2) exp lr(( -frac((bold(y) - bold(X) bold(beta))^T (bold(y) - bold(X) bold(beta)), 2sigma^2) ))
$

#v(0.5em)

== Part (b): Joint Prior Distribution

The priors are assumed independent:

$
beta_0 approx cal(N)(0, 1000), quad beta_1 approx cal(N)(0, 1000), quad sigma^2 approx "IG"(a, b)
$

The joint prior density is:

$
p(beta_0, beta_1, sigma^2) = p(beta_0) \u{22C5} p(beta_1) \u{22C5} p(sigma^2)
$

$
= frac(1, sqrt(2 pi dot 1000)) exp lr(( -frac(beta_0^2, 2000) ))
  \u{22C5} frac(1, sqrt(2 pi dot 1000)) exp lr(( -frac(beta_1^2, 2000) ))
  \u{22C5} frac(b^a, Gamma(a)) (sigma^2)^(-(a+1)) exp lr(( -frac(b, sigma^2) ))
$

In matrix form with $bold(beta) = (beta_0, beta_1)^T$ and prior covariance $bold(V)_0 = 1000 dot bold(I)_2$:

$
p(bold(beta), sigma^2) prop |bold(V)_0|^(-1/2) exp lr(( -frac(1,2) bold(beta)^T bold(V)_0^(-1) bold(beta) ))
  \u{22C5} (sigma^2)^(-(a+1)) exp lr(( -frac(b, sigma^2) ))
$

#v(0.5em)

== Part (c): Joint Posterior Distribution

By Bayes' theorem:

$
p(bold(beta), sigma^2 | bold(y)) prop p(bold(y) | bold(beta), sigma^2) \u{22C5} p(bold(beta)) \u{22C5} p(sigma^2)
$

$
prop (sigma^2)^(-n/2) exp lr(( -frac((bold(y) - bold(X)bold(beta))^T(bold(y) - bold(X)bold(beta)), 2sigma^2) ))
\u{22C5} exp lr(( -frac(1,2) bold(beta)^T bold(V)_0^(-1) bold(beta) ))
\u{22C5} (sigma^2)^(-(a+1)) exp lr(( -frac(b, sigma^2) ))
$

This joint posterior does not have a simple closed form directly, but it factors into recognizable conditionals (see parts (d) and (e)).

#v(0.5em)

== Part (d): Conditional Posterior of $bold(beta) | sigma^2, bold(y)$

Treating $sigma^2$ as fixed and collecting terms in $bold(beta)$:

$
p(bold(beta) | sigma^2, bold(y)) prop exp lr(( -frac(1,2) lr([ bold(beta)^T lr(( frac(bold(X)^T bold(X), sigma^2) + bold(V)_0^(-1) )) bold(beta) - 2 bold(beta)^T frac(bold(X)^T bold(y), sigma^2) ]) ))
$

This is a multivariate normal kernel. Define:

$
bold(V)_n = lr(( bold(V)_0^(-1) + frac(bold(X)^T bold(X), sigma^2) ))^(-1), quad bold(m)_n = bold(V)_n lr(( frac(bold(X)^T bold(y), sigma^2) ))
$

(The prior mean is zero so the $bold(V)_0^(-1) bold(m)_0$ term vanishes.) Then:

$
bold(beta) | sigma^2, bold(y) approx cal(N)(bold(m)_n, bold(V)_n)
$

where

$
bold(V)_n = lr(( frac(1,1000) bold(I)_2 + frac(bold(X)^T bold(X), sigma^2) ))^(-1), quad bold(m)_n = bold(V)_n frac(bold(X)^T bold(y), sigma^2)
$

#v(0.5em)

== Part (e): Marginal Posterior of $sigma^2 | bold(y)$

Integrating out $bold(beta)$ from the joint posterior analytically (completing the square in $bold(beta)$ and using the Gaussian normalization constant), one obtains:

$
sigma^2 | bold(y) approx "IG"(a_n, b_n)
$

with updated parameters:

$
a_n = a + frac(n, 2)
$

$
b_n = b + frac(1, 2) lr([ bold(y)^T bold(y) - bold(m)_n^T bold(V)_n^(-1) bold(m)_n ])
$

This accounts for the residual variation not explained by the regression.

#v(0.5em)

== Part (f): Estimation from the Joint Posterior

Since the joint posterior $p(bold(beta), sigma^2 | bold(y))$ is a *Normal--Inverse-Gamma* distribution, we can use the following strategies.

*Posterior Means:*

- $bb(E)[sigma^2 | bold(y)] = frac(b_n, a_n - 1)$ (from the marginal IG posterior, valid for $a_n > 1$).
- $bb(E)[bold(beta) | bold(y)]$: because $bold(m)_n$ depends on $sigma^2$, the marginal posterior mean of $bold(beta)$ requires integrating over $sigma^2$. In practice, *Gibbs sampling* (see below) provides the most reliable estimates.

*Gibbs Sampling (Monte Carlo approach):*

One can alternate between the two tractable conditional distributions:

+ Draw $sigma^(2(t)) approx "IG"(a_n, b_n)$ from the marginal posterior.
+ Draw $bold(beta)^((t)) approx cal(N)(bold(m)_n (sigma^(2(t))), bold(V)_n (sigma^(2(t))))$ from the conditional posterior.

After a burn-in period, the samples ${bold(beta)^((t)), sigma^(2(t))}$ are draws from the joint posterior. Posterior means are then computed as Monte Carlo averages:

$
hat(beta)_0 approx frac(1,T) sum_(t=1)^T beta_0^((t)), quad hat(sigma)^2 approx frac(1,T) sum_(t=1)^T sigma^(2(t))
$

*95% Credible Intervals:*

From the posterior samples, the 2.5th and 97.5th empirical percentiles of ${beta_j^((t))}$ give the 95% equal-tailed credible interval for $beta_j$. For $sigma^2$, one uses the corresponding quantiles of the $"IG"(a_n, b_n)$ distribution analytically, or from samples.

#v(0.5em)

== Part (g): Interpretation of Parameters

- *$beta_0$ (intercept):* The expected SBP (in mmHg) when PM2.5 exposure is $X = 0$ µg/m³. In practice this is an extrapolation beyond the observed range and should be interpreted cautiously.

- *$beta_1$ (slope):* The expected increase in SBP (in mmHg) for each additional 1 µg/m³ increase in PM2.5 exposure. A positive $hat(beta)_1$ would indicate that higher pollution levels are associated with higher blood pressure.

- *$sigma^2$ (error variance):* The residual variance of SBP around the regression line. It captures the variability in SBP not explained by PM2.5 exposure --- arising from other individual factors (age, diet, genetics, etc.). Its square root $sigma$ is the residual standard deviation in mmHg.

#v(0.5em)

== Part (h): Prediction for a New Individual with $X_"new" = 26$

Given a new PM2.5 value $X_"new" = 26$ µg/m³, the *posterior predictive distribution* for a new response $tilde(Y)$ is:

$
p(tilde(y) | bold(y), X_"new") = integral integral p(tilde(y) | bold(beta), sigma^2, X_"new") thin p(bold(beta), sigma^2 | bold(y)) thin dif bold(beta) thin dif sigma^2
$

This marginalizes over all uncertainty in the parameters. The result is a Student's $t$-distribution (under the Normal--Inverse-Gamma model), centered at:

$
hat(mu)_"new" = hat(beta)_0 + hat(beta)_1 \u{22C5} 26
$

*Practical procedure using posterior samples:*

For each posterior draw $(bold(beta)^((t)), sigma^(2(t)))$:

+ Compute the predicted mean: $mu_"new"^((t)) = beta_0^((t)) + beta_1^((t)) times 26$.
+ Draw a predicted observation: $tilde(y)^((t)) approx cal(N)(mu_"new"^((t)), sigma^(2(t)))$.

The collection ${tilde(y)^((t))}$ forms the posterior predictive distribution. Its mean gives the point prediction, and its 2.5th/97.5th percentiles give a 95% *posterior predictive interval* --- which accounts for both parameter uncertainty and observation noise.
