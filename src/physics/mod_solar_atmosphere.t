!> User can use subroutine get_atm_para to generate 1D solar stmosphere.
!> User should provide heights (h), number density at the bottom,
!> number of points (nh), and the product of avaerage ion mass and 
!> gravity (mg) at each point. 
!> User can select temperature profile.
!> This subroutine will return density and pressure at each point.
!> please use cgs unit.
module mod_solar_atmosphere
  use mod_global_parameters
  use mod_constants
  implicit none

  integer :: n_valc,n_hong
  double precision :: h_valc(1:52),T_valc(1:52)
  double precision :: h_hong(1:300),T_hong(1:300)

  data n_valc / 52 /

  data    h_valc /    -75,    -50,     25,      0,     50, & 
                      100,    150,    250,    350,    450, &
                      515,    555,    605,    655,    705, &
                      755,    855,    905,    980,   1065, &
                     1180,   1280,   1380,   1515,   1605, &
                     1785,   1925,   1990,   2016,   2050, &
                     2070,   2080,   2090,   2104,   2107, &
                     2109,   2113,   2115,   2120,   2129, &
                     2160,   2200,   2230,   2255,   2263, &
                     2267,   2271,   2274,   2280,   2290, &
                     2298,   2543 /

  data    T_valc /   8320,   7610,   6910,   6420,   5840, &  
                     5455,   5180,   4780,   4465,   4220, &
                     4170,   4230,   4420,   4730,   5030, &
                     5280,   5650,   5755,   5925,   6040, &
                     6150,   6220,   6280,   6370,   6440, &
                     6630,   6940,   7160,   7360,   7660, &
                     7940,   8180,   8440,   9500,  10700, &
                    12300,  18500,  21000,  22500,  23000, &
                    23500,  24000,  24200,  24500,  25500, &
                    28000,  32000,  37000,  50000,  89100, &
                   141000, 447000 /


  data n_hong / 300 /

  data h_hong / -3.7616d+07, -3.7384d+07, -3.7045d+07, -3.6561d+07, -3.5880d+07,& 
                -3.4950d+07, -3.3718d+07, -3.2153d+07, -3.0250d+07, -2.8050d+07,&
                -2.5627d+07, -2.3088d+07, -2.0556d+07, -1.8151d+07, -1.5972d+07,&
                -1.4004d+07, -1.2234d+07, -1.0625d+07, -9.1510d+06, -7.7773d+06,&
                -6.4599d+06, -5.1584d+06, -3.8455d+06, -2.4946d+06, -1.0577d+06,&
                 4.7767d+05,  2.1041d+06,  3.8237d+06,  5.6198d+06,  7.4817d+06,&
                 9.3930d+06,  1.1339d+07,  1.3304d+07,  1.5278d+07,  1.7250d+07,&
                 1.9213d+07,  2.1163d+07,  2.3099d+07,  2.5019d+07,  2.6922d+07,&
                 2.8809d+07,  3.0678d+07,  3.2532d+07,  3.4371d+07,  3.6196d+07,&
                 3.8009d+07,  3.9811d+07,  4.1605d+07,  4.3396d+07,  4.5186d+07,&
                 4.6977d+07,  4.8773d+07,  5.0576d+07,  5.2390d+07,  5.4218d+07,&
                 5.6065d+07,  5.7934d+07,  5.9833d+07,  6.1766d+07,  6.3736d+07,&
                 6.5744d+07,  6.7791d+07,  6.9880d+07,  7.2011d+07,  7.4185d+07,&
                 7.6403d+07,  7.8660d+07,  8.0954d+07,  8.3284d+07,  8.5647d+07,&
                 8.8038d+07,  9.0456d+07,  9.2896d+07,  9.5357d+07,  9.7838d+07,&
                 1.0033d+08,  1.0285d+08,  1.0537d+08,  1.0791d+08,  1.1046d+08,&
                 1.1302d+08,  1.1559d+08,  1.1818d+08,  1.2077d+08,  1.2337d+08,&
                 1.2599d+08,  1.2862d+08,  1.3126d+08,  1.3392d+08,  1.3659d+08,&
                 1.3927d+08,  1.4198d+08,  1.4470d+08,  1.4744d+08,  1.5019d+08,&
                 1.5295d+08,  1.5571d+08,  1.5847d+08,  1.6121d+08,  1.6389d+08,&
                 1.6648d+08,  1.6895d+08,  1.7122d+08,  1.7325d+08,  1.7499d+08,&
                 1.7642d+08,  1.7754d+08,  1.7838d+08,  1.7900d+08,  1.7944d+08,&
                 1.7974d+08,  1.7996d+08,  1.8010d+08,  1.8020d+08,  1.8027d+08,&
                 1.8032d+08,  1.8035d+08,  1.8037d+08,  1.8039d+08,  1.8041d+08,&
                 1.8042d+08,  1.8044d+08,  1.8045d+08,  1.8046d+08,  1.8047d+08,&
                 1.8049d+08,  1.8051d+08,  1.8053d+08,  1.8055d+08,  1.8059d+08,&
                 1.8063d+08,  1.8068d+08,  1.8074d+08,  1.8082d+08,  1.8092d+08,&
                 1.8103d+08,  1.8118d+08,  1.8135d+08,  1.8157d+08,  1.8182d+08,&
                 1.8214d+08,  1.8252d+08,  1.8299d+08,  1.8357d+08,  1.8428d+08,&
                 1.8515d+08,  1.8621d+08,  1.8749d+08,  1.8904d+08,  1.9089d+08,&
                 1.9307d+08,  1.9561d+08,  1.9852d+08,  2.0180d+08,  2.0544d+08,&
                 2.0941d+08,  2.1368d+08,  2.1819d+08,  2.2291d+08,  2.2781d+08,&
                 2.3284d+08,  2.3798d+08,  2.4320d+08,  2.4849d+08,  2.5383d+08,&
                 2.5922d+08,  2.6463d+08,  2.7008d+08,  2.7554d+08,  2.8102d+08,&
                 2.8651d+08,  2.9202d+08,  2.9753d+08,  3.0305d+08,  3.0858d+08,&
                 3.1412d+08,  3.1966d+08,  3.2520d+08,  3.3075d+08,  3.3630d+08,&
                 3.4186d+08,  3.4741d+08,  3.5297d+08,  3.5854d+08,  3.6410d+08,&
                 3.6967d+08,  3.7523d+08,  3.8080d+08,  3.8637d+08,  3.9195d+08,&
                 3.9752d+08,  4.0309d+08,  4.0867d+08,  4.1424d+08,  4.1982d+08,&
                 4.2540d+08,  4.3098d+08,  4.3656d+08,  4.4214d+08,  4.4772d+08,&
                 4.5330d+08,  4.5888d+08,  4.6446d+08,  4.7004d+08,  4.7563d+08,&
                 4.8121d+08,  4.8679d+08,  4.9238d+08,  4.9796d+08,  5.0355d+08,&
                 5.0913d+08,  5.1472d+08,  5.2030d+08,  5.2589d+08,  5.3148d+08,&
                 5.3706d+08,  5.4265d+08,  5.4824d+08,  5.5382d+08,  5.5941d+08,&
                 5.6500d+08,  5.7059d+08,  5.7617d+08,  5.8176d+08,  5.8735d+08,&
                 5.9294d+08,  5.9853d+08,  6.0412d+08,  6.0971d+08,  6.1530d+08,&
                 6.2089d+08,  6.2648d+08,  6.3207d+08,  6.3766d+08,  6.4325d+08,&
                 6.4884d+08,  6.5443d+08,  6.6002d+08,  6.6561d+08,  6.7120d+08,&
                 6.7679d+08,  6.8238d+08,  6.8798d+08,  6.9357d+08,  6.9916d+08,&
                 7.0475d+08,  7.1034d+08,  7.1593d+08,  7.2152d+08,  7.2712d+08,&
                 7.3271d+08,  7.3830d+08,  7.4389d+08,  7.4948d+08,  7.5508d+08,&
                 7.6067d+08,  7.6626d+08,  7.7185d+08,  7.7744d+08,  7.8304d+08,&
                 7.8863d+08,  7.9422d+08,  7.9981d+08,  8.0540d+08,  8.1100d+08,&
                 8.1659d+08,  8.2218d+08,  8.2777d+08,  8.3337d+08,  8.3896d+08,&
                 8.4455d+08,  8.5014d+08,  8.5574d+08,  8.6133d+08,  8.6692d+08,&
                 8.7252d+08,  8.7811d+08,  8.8370d+08,  8.8929d+08,  8.9489d+08,&
                 9.0048d+08,  9.0607d+08,  9.1166d+08,  9.1726d+08,  9.2285d+08,&
                 9.2844d+08,  9.3404d+08,  9.3963d+08,  9.4522d+08,  9.5082d+08,&
                 9.5641d+08,  9.6200d+08,  9.6759d+08,  9.7319d+08,  9.7878d+08,& 
                 9.8437d+08,  9.8997d+08,  9.9556d+08,  1.0012d+09,  1.0067d+09 /

  data T_hong / 1.0000d+04, 1.0000d+04, 1.0001d+04, 1.0002d+04, 1.0003d+04,&  
                1.0005d+04, 1.0008d+04, 1.0012d+04, 1.0018d+04, 1.0026d+04,&
                1.0036d+04, 1.0047d+04, 1.0058d+04, 1.0011d+04, 9.6700d+03,&
                9.3468d+03, 8.9643d+03, 8.6116d+03, 8.2357d+03, 7.8466d+03,&
                7.4734d+03, 7.1441d+03, 6.8397d+03, 6.5263d+03, 6.2978d+03,&
                6.1165d+03, 5.9274d+03, 5.7787d+03, 5.6233d+03, 5.4920d+03,&
                5.3684d+03, 5.2602d+03, 5.1621d+03, 5.0768d+03, 4.9988d+03,&
                4.9202d+03, 4.8435d+03, 4.7743d+03, 4.7107d+03, 4.6492d+03,&
                4.5903d+03, 4.5333d+03, 4.4783d+03, 4.4272d+03, 4.3832d+03,&
                4.3391d+03, 4.2948d+03, 4.2540d+03, 4.2277d+03, 4.2067d+03,&
                4.1940d+03, 4.1851d+03, 4.1956d+03, 4.2262d+03, 4.2723d+03,&
                4.3381d+03, 4.4204d+03, 4.5278d+03, 4.6445d+03, 4.7643d+03,&
                4.8856d+03, 5.0037d+03, 5.1176d+03, 5.2250d+03, 5.3211d+03,&
                5.4063d+03, 5.4888d+03, 5.5778d+03, 5.6443d+03, 5.7069d+03,&
                5.7603d+03, 5.8132d+03, 5.8700d+03, 5.9167d+03, 5.9592d+03,&
                5.9938d+03, 6.0256d+03, 6.0561d+03, 6.0805d+03, 6.1051d+03,&
                6.1298d+03, 6.1515d+03, 6.1720d+03, 6.1904d+03, 6.2096d+03,&
                6.2281d+03, 6.2458d+03, 6.2654d+03, 6.2877d+03, 6.3134d+03,&
                6.3429d+03, 6.3754d+03, 6.4108d+03, 6.4497d+03, 6.4949d+03,&
                6.5456d+03, 6.6066d+03, 6.6837d+03, 6.7794d+03, 6.8983d+03,&
                7.0383d+03, 7.1943d+03, 7.3537d+03, 7.4943d+03, 7.6133d+03,&
                7.7131d+03, 7.8049d+03, 7.8909d+03, 7.9677d+03, 8.0333d+03,&
                8.0851d+03, 8.1219d+03, 8.1534d+03, 8.2225d+03, 8.4087d+03,&
                8.7744d+03, 9.3187d+03, 1.0097d+04, 1.1128d+04, 1.2398d+04,&
                1.3941d+04, 1.5857d+04, 1.8286d+04, 2.1320d+04, 2.4676d+04,&
                2.7878d+04, 3.0947d+04, 3.4019d+04, 3.7182d+04, 4.0498d+04,&
                4.4021d+04, 4.7801d+04, 5.1890d+04, 5.6344d+04, 6.1230d+04,&
                6.6619d+04, 7.2587d+04, 7.9209d+04, 8.6564d+04, 9.4709d+04,&
                1.0364d+05, 1.1329d+05, 1.2363d+05, 1.3469d+05, 1.4653d+05,&
                1.5920d+05, 1.7275d+05, 1.8719d+05, 2.0250d+05, 2.1859d+05,&
                2.3535d+05, 2.5260d+05, 2.7013d+05, 2.8767d+05, 3.0498d+05,&
                3.2184d+05, 3.3811d+05, 3.5372d+05, 3.6862d+05, 3.8283d+05,&
                3.9636d+05, 4.0926d+05, 4.2157d+05, 4.3333d+05, 4.4459d+05,&
                4.5538d+05, 4.6575d+05, 4.7573d+05, 4.8535d+05, 4.9464d+05,&
                5.0362d+05, 5.1232d+05, 5.2076d+05, 5.2895d+05, 5.3691d+05,&
                5.4467d+05, 5.5222d+05, 5.5958d+05, 5.6677d+05, 5.7379d+05,&
                5.8066d+05, 5.8738d+05, 5.9395d+05, 6.0040d+05, 6.0672d+05,&
                6.1291d+05, 6.1900d+05, 6.2497d+05, 6.3084d+05, 6.3661d+05,&
                6.4228d+05, 6.4786d+05, 6.5335d+05, 6.5876d+05, 6.6408d+05,&
                6.6933d+05, 6.7450d+05, 6.7960d+05, 6.8463d+05, 6.8959d+05,&
                6.9449d+05, 6.9932d+05, 7.0409d+05, 7.0880d+05, 7.1346d+05,&
                7.1806d+05, 7.2260d+05, 7.2709d+05, 7.3154d+05, 7.3593d+05,&
                7.4027d+05, 7.4457d+05, 7.4882d+05, 7.5303d+05, 7.5719d+05,&
                7.6131d+05, 7.6539d+05, 7.6943d+05, 7.7343d+05, 7.7739d+05,&
                7.8131d+05, 7.8518d+05, 7.8898d+05, 7.9272d+05, 7.9641d+05,&
                8.0004d+05, 8.0362d+05, 8.0715d+05, 8.1063d+05, 8.1406d+05,&
                8.1745d+05, 8.2079d+05, 8.2409d+05, 8.2734d+05, 8.3056d+05,&
                8.3373d+05, 8.3687d+05, 8.3997d+05, 8.4303d+05, 8.4606d+05,&
                8.4906d+05, 8.5205d+05, 8.5502d+05, 8.5796d+05, 8.6090d+05,&
                8.6381d+05, 8.6670d+05, 8.6958d+05, 8.7244d+05, 8.7528d+05,&
                8.7810d+05, 8.8091d+05, 8.8371d+05, 8.8648d+05, 8.8924d+05,&
                8.9199d+05, 8.9472d+05, 8.9743d+05, 9.0013d+05, 9.0281d+05,&
                9.0548d+05, 9.0814d+05, 9.1078d+05, 9.1341d+05, 9.1602d+05,&
                9.1862d+05, 9.2121d+05, 9.2378d+05, 9.2634d+05, 9.2889d+05,&
                9.3142d+05, 9.3394d+05, 9.3645d+05, 9.3895d+05, 9.4143d+05,&
                9.4391d+05, 9.4637d+05, 9.4882d+05, 9.5126d+05, 9.5368d+05,&
                9.5610d+05, 9.5850d+05, 9.6089d+05, 9.6328d+05, 9.6565d+05,&
                9.6801d+05, 9.7036d+05, 9.7270d+05, 9.7503d+05, 9.7735d+05,&
                9.7965d+05, 9.8195d+05, 9.8424d+05, 9.8652d+05, 9.8879d+05,&
                9.9105d+05, 9.9330d+05, 9.9554d+05, 9.9778d+05, 9.9778d+05 /


contains

  subroutine get_atm_para(h,rho,pth,mg,nh,rho0,Tcurve)
    ! h [cm]
    ! rho [cm^-3]
    ! pth [dyne cm^-2]
    ! mg [g cm s^-2]
    ! nh -- number of points
    ! rho0 -- number density at h(1)
    ! Tcurve -- 'VAL-C' | 'Hong2017' | 'YS2001'

    integer :: nh
    double precision :: rho0
    double precision :: h(nh),rho(nh),pth(nh),mg(nh)
    character(20) :: Tcurve

    double precision :: Te(nh)
    integer :: j
    double precision :: invT,dh

    select case(Tcurve)
      case('VAL-C')
        call get_Te_VALC(h,Te,nh)
        if (mype==0) print *, 'VAL-C temperature curve'

      case('Hong2017')
        call get_Te_Hong(h,Te,nh)
        if (mype==0) print *, 'Temperature curve in Hong et al. (2017) is employed'

      case('YS2001')
        call get_NT_YS(h,rho,pth,nh,rho0)
        if (mype==0) print *, 'Temperature and density curves in Yokoyama & Shibata (2001) are employed'

      case default
        call mpistop("This temperature curve is unknown")

    end select


    ! density and pressure profiles
    if (Tcurve=='VAL-C' .or. Tcurve=='Hong2017') then
      rho(1)=rho0
      pth(1)=rho(1)*const_kb*Te(1)

      invT=0.d0
      do j=2,nh
        dh=h(j)-h(j-1)
        invT=invT+dh*(mg(j)/(const_kb*Te(j))+mg(j-1)/(const_kb*Te(j-1)))*0.5d0
        pth(j)=pth(1)*dexp(invT)
        rho(j)=pth(j)/(const_kb*Te(j))
      end do
    endif

  end subroutine get_atm_para

  subroutine get_Te_VALC(h,Te,nh)
    use mod_interpolation
    use mod_constants

    integer :: nh
    double precision :: h(nh),Te(nh)

    integer :: ih,j,imin,imax,n_table
    double precision :: h_table(n_valc),T_table(n_valc)
    double precision :: unit_h,unit_T,htra,Ttra,Fc,kappa,dTdh

    ! temperature profile
    unit_h=1.d5 !  km -> cm
    unit_T=1.0  !  K -> K
    Fc=6*2.d5
    kappa=8.d-7

    n_table=n_valc
    h_table=h_valc*unit_h
    T_table=T_valc*unit_T
    htra=h_table(n_table)
    Ttra=T_table(n_table)
    dTdh=(T_table(2)-T_table(1))/(h_table(2)-h_table(1))

    do ih=1,nh
      if (h(ih)>h_table(n_table)) then
      ! above transition region
        Te(ih)=(3.5d0*Fc*(h(ih)-htra)/kappa+Ttra**3.5d0)**(2.d0/7.d0)
      endif

      if (h(ih)<=h_table(1)) then
      ! below photosphere
        Te(ih)=(h(ih)-h_table(1))*dTdh+T_table(1)
      endif
    enddo


    ! inside the table
    imin=nh
    imax=nh-1
    if (h(1)>=h_table(1) .and. h(1)<=h_table(n_table)) then
      imin=1
    else
      do ih=2,nh
        if (h(ih-1)<h_table(1) .and. h(ih)>=h_table(1) .and. h(ih)<=h_table(n_table)) imin=ih
      enddo
    endif
    if (h(nh)>=h_table(1) .and. h(nh)<=h_table(n_table)) then
      imax=nh
    else
      do ih=1,nh-1
        if (h(ih)<=h_table(n_table) .and. h(ih+1)>h_table(n_table) .and. h(ih)>=h_table(1)) imax=ih
      enddo
    endif

    if (imin<=imax) then
      call interp_linear(h_table,T_table,n_valc,h(imin:imax),Te(imin:imax),imax-imin+1)
    endif

  end subroutine get_Te_VALC

  subroutine get_Te_Hong(h,Te,nh)
    use mod_interpolation
    use mod_constants

    integer :: nh
    double precision :: h(nh),Te(nh)

    integer :: ih,j,imin,imax,n_table
    double precision :: h_table(n_hong),T_table(n_hong)
    double precision :: dTdh

    n_table=n_hong
    h_table=h_hong
    T_table=T_hong

    do ih=1,nh
      if (h(ih)>=h_table(n_table)) then
      ! above max height of the table
        dTdh=(T_table(n_table)-T_table(n_table-1))/(h_table(n_table)-h_table(n_table-1))
        Te(ih)=(h(ih)-h_table(n_table))*dTdh+T_table(n_table)
      endif

      if (h(ih)<=h_table(1)) then
      ! below min height of the table
        dTdh=(T_table(2)-T_table(1))/(h_table(2)-h_table(1))
        Te(ih)=(h(ih)-h_table(1))*dTdh+T_table(1)
      endif
    enddo


    ! inside the table
    imin=nh
    imax=nh-1
    if (h(1)>=h_table(1) .and. h(1)<=h_table(n_table)) then
      imin=1
    else
      do ih=2,nh
        if (h(ih-1)<h_table(1) .and. h(ih)>=h_table(1) .and. h(ih)<=h_table(n_table)) imin=ih
      enddo
    endif
    if (h(nh)>=h_table(1) .and. h(nh)<=h_table(n_table)) then
      imax=nh
    else
      do ih=1,nh-1
        if (h(ih)<=h_table(n_table) .and. h(ih+1)>h_table(n_table) .and. h(ih)>=h_table(1)) imax=ih
      enddo
    endif

    if (imin<=imax) then
      call interp_linear(h_table,T_table,n_table,h(imin:imax),Te(imin:imax),imax-imin+1)
    endif

  end subroutine get_Te_Hong

  subroutine get_NT_YS(h,rho,pth,nh,rho0)

    integer :: nh
    double precision :: rho0
    double precision :: h(nh),rho(nh),pth(nh)

    integer :: ih
    double precision :: htra,wtra,rhoc

    htra=0.3d9 ! height of initial transition region
    wtra=0.06d9 ! width of initial transition region 
    rhoc=rho0/1d5
    pth=0.47/1.67

    do ih=1,nh
      rho(ih)=rhoc+(rho0-rhoc)*(1.d0-tanh((h(ih)-htra)/wtra))
    enddo

  end subroutine get_NT_YS

end module mod_solar_atmosphere
