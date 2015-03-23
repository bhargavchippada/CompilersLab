void q()
{
    int g, h;
    void r()
    {
	void p() 
	{
	    int a;
	    a = g + h;
	};
	p();
    };
    r();
}


;; Function q (q)

q ()
{
  struct FRAME.q FRAME.0;
  int g;
  int h;
  static void r (void);

  r () [static-chain: &FRAME.0];
}



;; Function r (r.1168)

r ()
{
  struct FRAME.r FRAME.1;
  static void p (void);

  FRAME.1.__chain = CHAIN.3;
  p () [static-chain: &FRAME.1];
}



;; Function p (p.1170)

p ()
{
  struct FRAME.q * D.1178;
  int D.1179;
  struct FRAME.q * D.1181;
  int D.1182;
  int a;

  D.1178 = CHAIN.2->__chain;
  D.1179 = D.1178->g;
  D.1181 = CHAIN.2->__chain;
  D.1182 = D.1181->h;
  a = D.1179 + D.1182;
}


