#Flow map
def f(xi,t):
    q1 = xi[0]
    q2 = xi[1]
    p1 = xi[2]
    p2 = xi[3]
    u = IterEnergyShaping(xi,t)
    dq1dt = p1/m1
    dq2dt = p2/m2
    dp1dt = -m1*gamma - b1*p1/m1 + u
    dp2dt = -m2*gamma - b2*p2/m2
    return [dq1dt,dq2dt,dp1dt,dp2dt]

#Jump map
def g(xi):
    global state
    global flag_jump
    q1 = xi[0]
    q2 = xi[1]
    p1 = xi[2]
    p2 = xi[3]
    if not flag_jump:
        # Resolve collision ball-ground
        xip = [q1,q2,p1,-cg*p2]
        state = 0
        #print('-> bg collision resolved')
    else:
        # Resolve collision ball-robot
        l = (ci+1)/(m1+m2)
        dp = m2*p1 - m1*p2
        xip = [q1,q2,p1-l*dp,p2+l*dp]      
        state = 0
        #print('-> br collision resolved')
    return xip

#Flow set
def C(xi):
    x = xi[0]
    v = xi[1]
    inside = 1
    if x < 0:
        inside = 0
    return inside

# Jump set
def D(xi):
    global state
    global flag_jump
    global hit
    q1 = xi[0]
    q2 = xi[1]
    p1 = xi[2]
    p2 = xi[3]
    if ((q2<=0) and (p2<0)):
        jump = 1
        flag_jump = 0
        hit = 1
        state = 0
        print('-> B-G collision')
    elif (q1-q2)<=0:
        sp1 = np.sign(p1)
        sp2 = np.sign(p2)
        if (sp1>=0) and (sp2>=0) and (p2/m2>=p1/m1):
            jump = 1
            flag_jump = 1
            hit = 1
            state = 0
            print('-> R-B collision')
        elif (sp1<=0) and (sp2>=0):
            jump = 1
            flag_jump = 1
            hit = 1
            state = 0
            print('-> R-B collision')
        elif (sp1<=0) and (sp2<=0) and (abs(p2/m2)<=abs(p1/m1)):
            jump = 1
            flag_jump = 1
            hit = 1
            state = 0
            print('-> R-B collision')
        else:
            jump = 0
    else:
        jump = 0
    return jump

# Detect Max function
def DetectMax(q,p):
    global q2o
    global p2o
    global maxo
    sp2 = np.sign(p2o)
    if (np.sign(p)!=sp2) and (sp2==1):
        flag = 1
        maxi = 0.5*(q+q2o)
        maxo = maxi
    else:
        flag = 0
        maxi = maxo
    q2o = q
    p2o = p
    return [flag, maxi]

# Compute the Iterative Energy Shaping control action
def IterEnergyShaping(xi,t):
    global hit
    global state
    global e_int
    global phi
    # data variables
    global err
    global gain
    global sigma_q1
    global sigma_q2
    global sigma_p1
    #
    nq1 = sigma_q1*np.sin(10000*t + 2.0) 
    nq2 = sigma_q2*np.sin(11000*t + 1.0)
    np1 = sigma_p1*np.sin(12000*t + 0.5)
    #
    q1 = xi[0] + nq1
    q2 = xi[1] + nq2
    p1 = xi[2] + np1
    p2 = xi[3]
    # Detect if the ball has reached the peak
    [flag,maxi] = DetectMax(q2,p2)
    # Determine Controller state and update the learning control loop
    if flag and hit:
        e = q2md-maxi
        e_int += e
        phi = sigma*(kp*e + ki*e_int)
        hit = 0
        state = 1
        err = np.append(err,e)
        gain = np.append(gain,phi)
        print('Peak Detected at','%.4f' % maxi)
        print(' Error:','%.4f'% e)
        print(' Cumulative Error:','%.4f'% e_int)
    # Compute control action
    if state:
        q1d = q2
        beta = m1*gamma - phi*(q1-q1d)
        v = -kd_hit*p1
    elif not state:
        q1d = q2 + h 
        beta = m1*gamma - 2*kp_wait*(q1-q1d)
        v = -kd_wait*p1
    else:
        beta =  0
        v = 0
    return beta + v