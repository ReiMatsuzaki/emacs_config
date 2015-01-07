#ifndef ERFC.BAK_HPP
#define ERFC.BAK_HPP

typedef std::complex<double> DC;

std::complex<double> erfc_dc_at_n(std::complex<double> x, unsigned int n) {
  std::complex<double> tmp;
  std::complex<double> nnhh;
  double h = sqrt(M_PI / n);

  tmp = 0.0;
  for(unsigned int i = 0; i < n; i++) {
    nnhh = (2.0 * i + 1.0) * h / 2.0;
    nnhh = nnhh * nnhh;
    tmp += exp(-nnhh) / (nnhh + x * x);
  }
  tmp *= 2.0 * h / M_PI * exp(-x*x) * x;
  
  if(x.real() + std::abs(x.imag()) < M_PI/h)
    tmp += 2.0 / (1.0 + exp(2*M_PI * x / h));
      
  return tmp;
}
std::complex<double> erfc_dc_last_term_at_n(std::complex<double> x, unsigned int n) {
  std::complex<double> tmp;
  std::complex<double> nnhh;
  std::complex<double> h = sqrt(M_PI / n);

  nnhh = (2.0 * n - 1.0) * h / 2.0;
  nnhh = nnhh * nnhh;
  tmp = exp(-nnhh) / (nnhh + x * x);
  tmp *= 2.0 * h / M_PI * exp(-x*x) * x;
      
  return tmp;
}
int erfc_dc(std::complex<double> x, std::complex<double> &y,erfc_calc_data &data) {
  
  std::complex<double> at_n, last_term, ratio;
  double eps = 1.5 * 2.22 * pow(10.0, -16.0);
  unsigned int i;

  data.convergence = false;
  for(i = 10; i < 15; i++) {
    at_n = erfc_dc_at_n(x, i);
    last_term = erfc_dc_last_term_at_n(x, i);
    ratio = last_term / at_n;
    data.num_term = i;

    if(abs(ratio) < eps) {
      data.convergence = true;
      break;
    }
  }

  y = at_n;

  if(data.convergence)
    return(0);
  else
    return (1);
}

TEST(erfc, erfc_double_compex) {
  
  std::complex<double> expect, x, y;
  erfc_calc_data calc_data;

  x = std::complex<double>(1.0, -1.0);
  expect = std::complex<double>(-0.316151281697947644880271080243670369027706529252, 0.190453469237834686284108861969162442437777309751);
  erfc_dc(x, y, calc_data);
  EXPECT_DOUBLE_EQ(real(expect), real(y));
  
  x = std::complex<double>(0.015707317311820675753295353309906770086948450734, 0.999876632481660598638907127731252174499277787538);
  expect = std::complex<double>(0.95184545524179913420177473658805102860103221495, -1.64929108965086517748934245403332000523564625901);
  erfc_dc(x, y, calc_data);
  EXPECT_DOUBLE_EQ(real(expect), real(y));
  EXPECT_DOUBLE_EQ(expect.imag(), y.imag());
  EXPECT_TRUE(calc_data.convergence);

  double eps = pow(10.0, -13);
  x = std::complex<double>(0.001564344650402308690101053194671668923139,0.009876883405951377261900402476934372607584);
  expect = std::complex<double>(0.9982346553205423153337357292658472915601, -0.0111452046101524188315708507537751407281);
  erfc_dc(x, y, calc_data);
  EXPECT_TRUE(calc_data.convergence);
  EXPECT_NEAR(real(expect), real(y), eps);
  EXPECT_NEAR(expect.imag(), y.imag(), eps);
}

#endif
