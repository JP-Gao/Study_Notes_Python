###  Excel Macros



# 195 * 1.618

###  Packages  -------------------
# _______________________________________________________________________


# Pakcages we will use:
cat("\n")
list.of.packages <-
  c(
    
    # visualization
    "ggplot2","scales",
    
    # regular expression
    "stringr",
    
    # foriegn data
    "rjson","XML","RJSONIO",
    
    # data maniputaltion
    "reshape","reshape2","data.table","plyr","dplyr","magrittr","DataCombine",
    
    # some functions in dplyr are duplicate in plyr, and we want to use functions in dplyr
    # so load plyr first and then let dplyr to mask it.
    
    # panel and cross sectional data
    # "plm","AER","censReg",'MASS',
    
    # model 
    'linear.tools',"MASS","glmnet","gbm","mboost",
    # time series
    "lubridate", "zoo","tseries",
    
    # literature programming & code style
    "knitr","formatR",'rmarkdown'# 'yaml', 'htmltools', 'caTools',"xtable",
    
    # Computing on the Language
    # "pryr", "gtools","lazyeval"
    
  )

cat("Pakcages we will use : \n")
print(list.of.packages)

cat("\n \n check new packages that this computer did not install before \n")

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]


if(length(new.packages)) {
  cat("\n \n download & install new packages \n")
  install.packages(new.packages)
}


cat("\n \n load packages to R \n")
for (Library in list.of.packages) library(Library,character.only = T)


opts_chunk$set(
  cache=FALSE,
  fig.width=6.8, 
  fig.height=4,
  fig.align='center',
  message=F,
  error=F,
  warning=F,
  tidy.opts = F,
  tidy = F
)



options(stringsAsFactors = FALSE, na.rm=T,warn=1)


# ggplot2 default font size
theme_set(theme_bw(base_size = 13))


# define the default colors used in deck
ured = rgb(r = 153, g = 0, b = 0,max = 255)
ugreen= rgb(95,163,100,max = 255)
ublue= rgb(100,144,243,max = 255)
umix = rgb(red = 235,green = 242, blue = 245, max = 255) # this is background color

utheme = theme(panel.grid = element_blank(),
               panel.background = element_rect(fill = umix),
               legend.background = element_rect(fill = umix),
               plot.background  = element_rect(fill = umix),
               plot.title = element_text(size = 13),
               panel.border = element_rect(linetype = NULL, colour = NULL),
               legend.position = "bottom")


###  Quick Functions  -------------------
# _______________________________________________________________________





if (!exists("print.data.frame2")){
  # only load these they are not defined
  # only print data for the first 200 rows

  print.data.frame2=print.data.frame
  print.data.frame=function(x){
    y=min(nrow(x),200 )
    print.data.frame2(x[1:y,,drop = F]) # use drop = F option to keep the data.frame class
  }
}







# print(data.frame(1:4))

# use drop = F option to keep the data.frame class
# x = data.frame(1:4)
# x[1:3,]
# x[1:3,,drop = F]

Enter_to_Continue=function(Pairs_data.frame = NA){
  # from attach_load_first.R
  # Type words in keyboard, return certain values, and then continue
  # Enter_to_Continue when you are in thr process of runing code

  # Pairs_data.frame shall be a two column data.frame, with first column as what you want to type,
  # second column as what you want to return
  # an example would be: Pairs_data.frame = rbind(c('small','small data'),c('n','normal'),c('w','weird curve'))
  Return=NA

  cat ("\n .... Press [enter] to continue; Type [s] to stop ....")

  if (!is.null(Pairs_data.frame) && !is.na(Pairs_data.frame) &&
      nrow(Pairs_data.frame)>0){
    for (pair_row in 1:nrow(Pairs_data.frame)) {
      # pair = List[[1]]
      cat("\n .... Type [ ",paste(Pairs_data.frame[pair_row,1])," ]"," to return '",
          paste(Pairs_data.frame[pair_row,2]),"' as object 'Return' ....",sep='')
    }
  }

  line <- readline()
  if (line=='s' | line=='S') stop("Stop ! ")

  # line = 'small'
  if (!is.null(Pairs_data.frame) && !is.na(Pairs_data.frame) &&
      nrow(Pairs_data.frame)>0 ) {

    Match = match(line,paste(Pairs_data.frame[,1]))
    Return = Pairs_data.frame[Match,2]
  }
  Return

  # unit test code:
  # Enter_to_Continue(rbind(c('small','small data'),c('n','normal'),c('w','weird curve')))

}

equal =  function(x,y) {
  # an attach_Load_First.R function

  # USED to replace == to when compare two numeric values
  # a lot times two numeric values are not the same in R
  # example
  # 3.3/3 == 1.1

  # so this function can do the comparision correctly.

  return(mapply(function(x, y) {isTRUE(all.equal(x, y))}, a, b))
  if(F){
    22.1 == (22.2 -0.1)
    equal(22.1, 22.2 -0.1)
  }
}

sum2 = function(x){
  # an attach_Load_First.R function

  # sum sometimes failed when using with %>%
  # this one is guaranteed to work
  x = list(x)

  y = 0
  for (i in x[[1]]){
    y = y + i
  }
  y
}






hot = function(full_day_off, hald_day_off,
               Personal_Total, Vacation_Total, Name = "FAN YANG"){

  # an attach_Load_First.R function

  Vaction_Left = Vacation_Total + Personal_Total - length(full_day_off)*8 - length(hald_day_off)/2*8

  off_summary = data.frame(date = c(full_day_off,hald_day_off))
  off_summary$hours_off = 4
  off_summary$hours_off[1:length(full_day_off)] = 8

  off_summary$date = as.Date(off_summary$date)

  off_summary$weekday = weekdays(off_summary$date)
  off_summary =  arrange(off_summary,date)

  off_cummu = cumsum( off_summary$hours_off )

  off_summary$hours_left = Personal_Total + Vacation_Total - off_cummu

  output = rbind.fill(data.frame(hours_left = Personal_Total + Vacation_Total),
                      off_summary)

  output = output[,c("date","weekday","hours_off","hours_left")]

  message("------------------------------------------")
  message("            ",Name,"              ")
  message("------------------------------------------")
  message("Beginning Personal hours: ", Personal_Total)
  message("Beginning PTO hours: ", Vacation_Total)
  message("Beginning Total hours (Personal + Vacation): ", Personal_Total + Vacation_Total)

  cat("\n\n")
  print(output)
  cat("\n\n")
  message("------------------------------------------")
  message("Ending unused hours: ", tail(output$hours_left,1) %>% sprintf("%.2f",.) )

  return(invisible(output))

  if(F){

    Vacation_Total = 66.65
    Personal_Total = 8

    full_day_off = c("2015-09-08",
                     "2015-11-27","2015-11-30","2015-12-01",
                     "2015-12-28","2015-12-29","2015-12-30","2015-12-31")

    hald_day_off = c("2015-10-23")
    hot(full_day_off,hald_day_off, Personal_Total,Vacation_Total)

  }

}



if (F){
  # let the mouse move!

  install.packages("rJava")          # install package
  library(rJava)                     # load package
  .jinit()                           # this starts the JVM
  jRobot <- .jnew("java/awt/Robot")  # Create object of the Robot class

  # Let java sleep 500 millis between the simulated mouse events
  .jcall(jRobot, "setAutoDelay",as.integer(333))

  # move mouse to 100,200 and select the text up to (100,300)

  move_mouse = function(min){
    for (i in 1:(min)){

      .jcall(jRobot, "mouseMove",as.integer(500),as.integer(200))
      .jcall(jRobot, "mouseMove",as.integer(500),as.integer(300))

      #   line <- readline()
      #   if (line=='s' | line=='S') stop("Stop ! ")

    }
  }

}



###  NA functions  =====================================================

check_missing = function(x){
  # an attach_Load_First.R function
  # check which column has missing values

  apply(data,2,function(x) sum(is.na(x)))
}


is.na.full = function(x){
  # an attach_Load_First.R function
  # whether all elements in vector/list x is na
  sum(is.na(x)) == length(x)
}

is.nonsense = function(x){
  # an attach_Load_First.R function

  is.null(x) || is.na(x) | is.nan(x) | is.infinite(x)
}


zero_not_null = function(Base){

  # transform a vector into 0 if it is NULL

  if(length(Base)==0){
    0
  } else {
    Base
  }
}


NA0= function(x){
  # from attach_load_first.R

  # for an vector, if it is NA, then become 0

  if (is.numeric(x)){
    y = is.na(x)
    if(y %>% sum) x[y] = 0
    x
  } else {
    x
  }
}



NULL0 = function(x){

  if ( is.null(x)){
    x = 0
  } else {
    x = NA0(x)
  }
  x
}


NA0.data.frame = function(data){
  # from attach_load_first.R

  # for an vector, if there is NA, then become 0

  for (i in colnames(data)){

    if (is.numeric(data[,i]) %>% sum){
      data[,i] = NA0(data[,i])
    }
  }
  data
}



clean_empty = function(x,clean0 = F){
  x = x[x!='' & !is.na(x)]
  if (clean0) x = x[float0(x)!=0]
  x
}



Expand.grid = function (List, KEEP.OUT.ATTRS = TRUE, stringsAsFactors = TRUE) {

  # from attach_load_first.R

  # same as expand.grid, only difference is Expland.grid here uses list as input here
  # Create a data frame from all combinations of the supplied vectors or factors

  nargs <- length(args <- List)
  if (!nargs)
    return(as.data.frame(list()))
  if (nargs == 1L && is.list(a1 <- args[[1L]]))
    nargs <- length(args <- a1)
  if (nargs == 0L)
    return(as.data.frame(list()))
  cargs <- vector("list", nargs)
  iArgs <- seq_len(nargs)
  nmc <- paste0("Var", iArgs)
  nm <- names(args)
  if (is.null(nm))
    nm <- nmc
  else if (any(ng0 <- nzchar(nm)))
    nmc[ng0] <- nm[ng0]
  names(cargs) <- nmc
  rep.fac <- 1L
  d <- sapply(args, length)
  if (KEEP.OUT.ATTRS) {
    dn <- vector("list", nargs)
    names(dn) <- nmc
  }
  orep <- prod(d)
  if (orep == 0L) {
    for (i in iArgs) cargs[[i]] <- args[[i]][FALSE]
  }
  else {
    for (i in iArgs) {
      x <- args[[i]]
      if (KEEP.OUT.ATTRS)
        dn[[i]] <- paste0(nmc[i], "=", if (is.numeric(x))
          format(x)
          else x)
      nx <- length(x)
      orep <- orep/nx
      x <- x[rep.int(rep.int(seq_len(nx), rep.int(rep.fac,
                                                  nx)), orep)]
      if (stringsAsFactors && !is.factor(x) && is.character(x))
        x <- factor(x, levels = unique(x))
      cargs[[i]] <- x
      rep.fac <- rep.fac * nx
    }
  }
  if (KEEP.OUT.ATTRS)
    attr(cargs, "out.attrs") <- list(dim = d, dimnames = dn)
  rn <- .set_row_names(as.integer(prod(d)))
  structure(cargs, class = "data.frame", row.names = rn)

  # Expand.grid(list(A= c(1:3),b= letters[1:4]))
  # Expand.grid(List = list(c(1:3)))

}


###  Time Functions  -------------------
# _______________________________________________________________________

month_end_delta= function(month_end,delta){
  # from attach_load_first.R

  # similar as db2date in sas

  #delta=12
  #month_end=201205
  YEAR=floor(month_end/100)
  MONTH=month_end-YEAR*100
  YEAR_delta=floor((MONTH+delta)/12)

  Replace=which(
    floor((MONTH+delta)/12)==(MONTH+delta)/12
  )
  YEAR_delta[Replace]=YEAR_delta[Replace]-1
  MONTH_delta=MONTH+delta-YEAR_delta*12
  #print(YEAR_delta)
  #print(MONTH_delta)
  YEAR*100+YEAR_delta*100+MONTH_delta

  # UNIT TEST::   month_end_delta(201401,-3)

}

as_Date_month_end=function(x = econ[,"mnemonic."] ,Format="%Y%m%d"){ # transfor month end to standard date format in R
  # from attach_load_first.R

  as.Date(paste(x,"01",sep=''),Format)
  # UNIT TEST::  as_Date_month_end(x=201404)

}



as_month_end=function(x,Numeric=F){
  # from attach_load_first.R

  # transfor date to month_end

  y= year(x)*100+month(x)
  if (Numeric) y= year(x)*12+month(x)
  y
}

month_end_diff = function(start=201101,end=201202){
  # from attach_load_first.R

  floor(end/100) * 12 - floor(start/100) * 12  +
    ( end - floor(end/100)*100) - (start - floor(start/100)*100)

  # UNIT TEST::
  # as_Date_month_end(x=201404)
  # month_end_diff(201102,201203)

}

stand_Q = function(x, Q_character = NULL){
  # an attach_Load_First.R function
  # return Q from  string like this c("x 4Qq","TEDSF 1Qq")

  # Q_character = 'Q'

  Q = rep(NA,length(x))
  x = tolower(x)
  for (i in c(1:4)){
    # i = 1
    if (length(Q_character)<=1 ){
      Q[str_detect(x,paste(i,tolower(Q_character),sep=''))] = i
    } else {

      if (length(Q_character)!=4) {
        stop("number of Q_characters are NOT 4. \n
             It must be either NULL, or with length 1 or 4.")
      }

      Q[str_detect(x,paste(i,tolower(Q_character)[i],sep=''))] = i

      }
  }
  return(as.numeric(Q))

  if (F){

    stand_Q(c("x 4Qq","TEDSF 1Qq"))

  }
}

stand_Y= function(x,Year_Range = c(c(2000:2025)),year_digits = 4){
  # an attach_Load_First.R function
  # return the year t from the string that contain years

  # year_digits: if in the string, the standard year format is 2 digits, then put year_digits = 2.

  Y = rep(NA,length(x))

  if (year_digits ==4 & max(str_length(Year_Range)) ==2){
    Year_Range = paste(20,Year_Range)
  }

  if (year_digits ==2 & max(str_length(Year_Range)) ==4){
    Year_Range = str_replace(Year_Range,'20','')
  }

  for (i in Year_Range){
    Y[str_detect(x,paste(i))] = i
  }

  return(as.numeric(Y))

  if(F){
    stand_Y(c("qeqwe 2004","fwef2007"))

    stand_Y(c("qeqwe 04","fwef07"),paste(0,1:9,sep=''))

  }
}

as.Date.q = function(a,position_q = 6){
  # an attach_Load_First.R function

  # make a standardized quarter string as date
  #   > as.Date.q(a = "2014 4q")
  #   [1] "2014-11-01"

  a_Q = substr(a, position_q,position_q)%>% as.numeric
  a_Y = substr(a, 1,4) %>% as.numeric

  month = a_Q *3 -1
  return(as.Date(paste(a_Y,month,"01",sep="-")))

  if (F){
    as.Date.q(a = "2014 4q")
  }
}



as.Date.m = function(x){
  (as.numeric(x)*100+ 1) %>% paste() %>% as.Date(.,"%Y%m%d")
}



diff_q = function(a,b,position_q = 6 ){
  # an attach_Load_First.R function

  # difference in Q between a and b: if b is later than a,
  # then shall return a positive number

  # for example 2011 4q has Q infor in the 6th digit

  a_Q = substr(a, position_q,position_q) %>% as.numeric
  b_Q = substr(b, position_q,position_q) %>% as.numeric
  a_Y = substr(a, 1,4) %>% as.numeric
  b_Y = substr(b, 1,4) %>% as.numeric

  # One difference year is 4q difference
  return(
    (b_Y - a_Y)*4 + b_Q - a_Q
  )

  # unit test
  if (F){

    diff_q(a = 2011.4,b = 2015.3)
    diff_q(a = 2011.4,b = 2015.4)

    diff_q(a = "2015 3Q" ,b = "2011 4Q",position_q = 6)
    diff_q(a = "20153Q" ,b = "20114Q",position_q = 5)

    diff_q(a = 2015.3 ,b = 2011.4)
    diff_q(a = 2015.4 ,b = 2011.4)

  }

}

change_q = function(q,
                    delta = 0, # numeric, the change of q
                    position_q = 6, # position_q means the position of Q infor in the string:
                    # for example 2011 4q has Q infor in the 6th digit
                    character = T # whether to return a standard character format
){
  # an attach_Load_First.R function

  # Let the quarter data move delta quarter forward or backward

  # q =c("2015.4",NA)

  #   > change_q( q= 2011.4,delta = 13)
  #   [1] "2015 1Q"

  a_Q = substr(q, position_q,position_q) %>% as.numeric
  a_Y = substr(q, 1,4) %>% as.numeric

  q = a_Q/10 + a_Y
  # transform the YYYYQ data into YYYY.Q as numeric
  result = q +
    delta%/%4 + #y
    delta%%4/10  # q

  result = as.numeric(result)

  for (i in 1:length(result)){
    # i=1

    if (!is.na(result[i]) && (result[i] > floor(result[i]) + 0.4) ){
      result[i] =  result[i] - (floor(result[i]) + 0.4) + floor(result[i]) + 1
    }

    #     if (!is.na(result[i]) && result[i] <= floor(result[i])){
    #       result[i] =  result[i] - floor(result[i]) + 0.4 + floor(result[i]) - 1
    #     }

  }

  for (i in 1:length(result)){
    if (!is.na(result[i]) && character){
      a_Q = substr(result[i], 6,6)
      a_Y = substr(result[i], 1,4)
      result[i] = paste(a_Y," ",a_Q,"Q",sep='')
    }
  }

  return(result)

  if (F){
    change_q( q= 2011.4,delta = 13)
    change_q( q= 2011.4,delta = 13,character = F)

    change_q( q= "2011 4Q",delta = 13,character = F)
    change_q( q= "2011 4Q",delta = 13)

    change_q( q= 2011.4,delta = -1)
    change_q( q= 2011.4,delta = 1)
    change_q( q= 2011.4,delta = 4)

    change_q( q= 2011.4,delta = -5)
    change_q( q= 2011.4,delta = -9)

    change_q( q= c(2011.4,2014.3),delta = -9)
    change_q( q= c(2011.4,2014.3,NA),delta = -9)

  }
}



month_str_to_num = function(x){

  # transform the string month names to number numbers
  # input is c("Dec", "Nov", "Apr", "Aug", "Feb", "Jan", "Jul", "Jun", "Mar", "May", "Oct", "Sep")
  # output is [1] 12 11  4  8  2  1  7  6  3  5 10  9

  if (sum((str_length(x) == 3)) == length(x)){
    result = match(x,str_sub(month.name,1,3))
  } else {
    result = match(x,month.name)
  }

  if ( sum(is.na(result))){
    warning("there are NA generated!")
  }

  return(result)

  if (F){
    month_str_to_num(
      x = c("Dec", "Nov", "Apr", "Aug", "Feb", "Jan", "Jul", "Jun", "Mar", "May", "Oct", "Sep")
    )
  }
}

month_to_Q = function(x,paste_with = NULL){

  # transform numeric month to numeric

  if (max(x)>12 | min(x)<1) {
    stop ('x has to be 1:12')
  }

  Q = (x-1)%/%3 + 1


  if (!is.null(paste_with)) {
    Q = paste(paste_with,Q,sep='')
  }
  names(Q) = x
  return(Q)


  if (F){

    month_to_Q(1:12,'Q')
    month_to_Q(1:13,'Q')
    month_to_Q(c(3,7,4,9),'Q')
    month_to_Q(c(3,7,4,9))

  }
}



###  Algebra Functions  -------------------
# _______________________________________________________________________



as.english_from_numeric = function(x){
  # not finished
  if ( x == 1) y = 'st'
  if ( x == 2) y = 'nd'
  if ( x == 3) y = 'rd'
  if ( x == 4) y = 'th'
  y
}



float0 = function(x,n = 5){
  # from attach_load_first.R
  # if a number is too small, then make that number to 0
  # x shall be a numeric vector

  too_small_p = abs(x)<10^(-n)

  if (sum(too_small_p)) x[too_small_p] = 0

  return(x)

  if (F){

    float0(0.9,0)

  }
}



Mode <- function(x) {
  # from attach_load_first.R
  # get mode number from a numeric vector
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

is.increase = function(x){
  # from attach_load_first.R

  # to check whether the vector is increasing
  all(x == cummax(x))
}
is.decrease = function(x){
  # from attach_load_first.R

  # to check whether the vector is increasing
  all(x == cummin(x))
}
# is.increase(1:10)
# is.increase(c(2,4,3)) # wrong

# is.decrease(10:1)

asc <- function(x) {
  # from attach_load_first.R

  # convert ASCII code to integers according to ASCII chart
  strtoi(charToRaw(x),16L)
}

lowest_numeric = function(x, N = 2, method = "position",
                          align = c("left","right","centered","all"),
                          second.lowest = F,
                          reverse_sign = F){

  # an attach_Load_First.R function

  # return the position / sum / mean of lowest N rolling elements
  align = match.arg(align)

  roll_mean = rollmean(x,k = N)
  if (reverse_sign) roll_mean = -roll_mean
  names(roll_mean) = 1:length(roll_mean)

  extreme_position = which.min(roll_mean)

  if (second.lowest) {
    extreme_2 = min(roll_mean[-extreme_position],na.rm=T)
    extreme_position = which(roll_mean == extreme_2)
  }

  extreme_position = extreme_position:(extreme_position+N-1)

  if ( method == 'position'){
    if (align == 'right') y = max(extreme_position,na.rm=T)
    if (align == 'left') y = min(extreme_position,na.rm=T)
    if (align == 'all') y = extreme_position
  }

  if (method == 'sum'){
    y = sum(x[extreme_position],na.rm=T)
  }
  if (method == 'mean'){
    y = mean(x[extreme_position],na.rm=T)
  }

  return(y)

  if (F) {
    set.seed(1)
    x = runif(10)
    x
    lowest_numeric(x)
    lowest_numeric(c(1,2,-10,4,-20,4324))
    lowest_numeric(c(1,2,-10,4,-20,4324),3)
    lowest_numeric(c(1,2,-10,4,-20,4324),4)

    lowest_numeric(c(1,2,-10,4,-20,4324),2,"sum")
    lowest_numeric(c(1,2,-10,4,-20,4324),3,"sum")
    lowest_numeric(c(1,2,-10,4,-20,4324),4,"sum")

    lowest_numeric(x = c(1,2,-10,4,-20,4324),N = 2,align = 'left',method = "position")
    lowest_numeric(x = c(1,2,-10,4,-20,4324),N = 2,align = 'all',method = "position")
    lowest_numeric(x = c(1,2,-10,4,-20,4324),N = 2,align = 'right',method = "position")

    lowest_numeric(c(1,2,-10,4,-20,4324),2,"mean")
    lowest_numeric(c(1,2,-10,4,-20,4324),2,"sum")

    lowest_numeric(c(1,2,-10,4,-20,4324),3,"mean")
    lowest_numeric(c(1,2,-10,4,-20,4324),4,"mean")
  }
}



add_peak = function(data, # a long data.frame
                    Length = 2, # length of the peak
                    metric = 'metric', # the numeric var # the metric that the peak bases on
                    timing = 'forecast_q', # timing variable of the peak
                    timing_constriants = 1:9, # only look at 1:9 rows in the timming variable
                    ...
){
  # ... = NULL
  print("add_peak is an attach_load_first.R function")

  # core function to identify the peak of rolling N Qs,

  data = data[,c(timing,metric)]

  unique.comb(data,index = timing,check_unique = T)

  sanity_check(timing_constriants,exact_in_match = data[,timing])



  forecast_period = which(data[,timing] %in% timing_constriants)


  # mean of the rolling N Qs
  data[forecast_period, "mean"] =
    rollmean(data[forecast_period,metric],Length,na.pad = T,align = "left")

  # peak
  lowest_data = data.frame( lowest_numeric(data[forecast_period,metric],Length,
                                           method = 'position',align = 'left',...)  %>%
                              data[forecast_period,timing][.],
                            lowest_numeric(data[forecast_period,metric],Length,'mean',...))

  # second_peak
  lowest_second = data.frame(

    lowest_numeric(data[forecast_period,metric],
                   Length,
                   method = 'position',
                   align = 'left',
                   second.lowest = T,...) %>% data[forecast_period,timing][.],

    lowest_numeric(data[forecast_period,metric],Length,'mean',second.lowest = T,...))

  colnames(lowest_data) = c(timing,"peak")
  colnames(lowest_second) = c(timing,"second_peak")


  data = Join(data,
              rbind.fill(lowest_data,lowest_second),
              by = timing)

  #____________ add the peaking time

  # single peak:  Q6 (first Q in the forecasting window), NA for other Qs
  data$peak_q =  NA
  peak_q_row = which(!is.na(data$peak))
  data$peak_q[peak_q_row]  = data[peak_q_row,timing]

  data$peak_q_full =  data$peak_q # initialize

  # full_peak: Q6-Q7 (full forecasting window), NA for other Qs
  for(Q_length in 1:(Length-1)){
    # Q_length = 1
    # print(Q_length)
    data$peak_q_full[peak_q_row + Q_length] = data$peak_q[peak_q_row] + Q_length
  }

  data$peak_ind_full = data$peak_ind =  0
  data$peak_ind[peak_q_row]  = data$peak_ind_full[peak_q_row]  = 1
  data$peak_ind_full[peak_q_row+1] = 1


  data$peak_sum = data$peak * Length
  data$sum = data$mean * Length
  data[data[,timing] %in% timing_constriants,]
}



### Functional Programming -------------------



eval_arguments = function(foo){

  # from attach_load_first.R

  # this function will evaluate all arguments (specified or un-specified as default)
  # in the input call globally
  # so that later you can easily do the test and debug

  foo_quote = lazy(foo)
  foo_quote$expr = standardise_call(foo_quote$expr)

  argument_spec_names = foo_quote$expr %>% names %>% .[-1]


  for( i in argument_spec_names){
    # i = argument_spec_names[2]
    cat("\n    creating", i,"\n")
    value = eval(foo_quote$expr[[i]])
    assign(i,value,envir = .GlobalEnv)
  }

  function_name = foo_quote[[1]][[1]]
  arguments_default = formals(eval(function_name))

  cat("\n ______ creating default arguments _____ \n")

  for (i in names(arguments_default)){

    if ( !i %in% argument_spec_names){

      if (i != '...') {
        cat("\n    creating", i,"\n")
        assign(i,eval(arguments_default[[i]]),envir = .GlobalEnv)
      }
    }
  }
}



###  Data Combine Functions  -------------------
# _______________________________________________________________________



Join = function(x, y, by = NULL, type = "left", match = "all",
                duplicate = c("delete","add","copy",'replace','suffix'),
                replace_var = NULL,
                PRINT=T,
                constraint.x = NULL, # condtions on x, only let those meet these condition to do Join
                constraint.y = NULL, # condtions on y, only let those meet these condition to do Join
                from_y = NULL,
                from_x = NULL,
                suffix_x = '_x',
                suffix_y = '_y'
){
  # from attach_load_first.R
  # this function is based on "join" (small cap !!) from dplyr.
  # To understand the join function, please enter ?join

  # Look out: when joined keys are numerics, note that R use floarting points so numeric looks the same will not equal!
  # like 22.1 == 22.2-0.1 is not TRUE.
  # so better to use factor or character.

  # _________ match __________
  # how should duplicate ids be matched? Either match just the "first" matching row, or match "all" matching rows.
  # Defaults to "all" for compatibility with merge and SQL, but "first" is significantly faster.
  # Default will give you the same behavior as SQL join does

  # _______ by ________
  # a character vector of variables to join by. If NULL, the default, join will do a natural join, using all variables
  # with common names across the two tables. A message lists the variables so that you can check they're right.
  # To join by different variables on x and y use a named vector.
  #   For example, by = c("a" = "b") will match x.a to y.b.
  #

  # ______ duplicate________ # it add functionalities about how to deal with duplicated variables
  ## note that the from_y argument will overwrite any duplicated names.

  # 'delete' means to delete all duplicated variables except the first one. This is the default option
  # 'add' means duplicated variables will be added up if it is numeric, or combined if it is character.
  # 'copy' means for those NA or NULL observations in dup vars of x,
  # we replace them by corresponding values in  y
  # 'replace' means we replace values in dup x if at the same row there is a value in dup y
  # replace_var can control which dup var you want to do replace
  # if replace_var = NULL, then replace all dup vars

  # 'suffix': put suffix_x on duplicated vars from x, put suffix_y from duplcated vars from y

  # If an element in "by" vector has its name attribute,
  # such as by = c("id_x"="id_y"), then we mean to match id_x in x with id_y in y
  # to achive this, we will
  # 1.change the "id_y" in y to "id_x"
  # 2.change the value "id_y" in the "by" vector to "id_x"

  duplicate = match.arg(duplicate)

  colnames(y) = clean_na_names(colnames(y))
  colnames(x) = clean_na_names(colnames(x))
  colnames(x) = clean_dup_names(colnames(x))
  colnames(y) = clean_dup_names(colnames(y))

  # duplicate = duplicate[1]

  # if no "by" provided, then assume common vars are "by"
  # this must be done after x = deletenames(x,from_y)
  if (is.null(by)) {
    by =  intersect(colnames(x),colnames(y))
    if (PRINT) message("BY the join index as: ",paste(by,collapese =' '))
  }


  # drop vars in x if those vars are specified in from_y
  # however, if that from_y var is in index used to match, then you cannot delete it.
  if ( !is.null(from_y) && !sum(from_y %in% colnames(y))){
    stop("from_y must be found in y")
  }

  if ( !is.null(from_y) && sum(from_y %in% colnames(y)) && sum(from_y %in% colnames(x)) ){

    if (sum(by %in% from_y)){
      if (PRINT) message(from_y[which(from_y %in% by)], ' shall be deleted from from_y as they are in the index')
      from_y= from_y[-which(from_y %in% by)]

    } else if (length(from_y)){
      if (PRINT) {
        message("below are from y ")
        print(from_y)
      }
      x = deletenames(x,from_y,PRINT = F)
    }
  }

  # drop vars in y if those vars are specified in from_x
  # however, if that from_x var is in index used to match, then you cannot delete it.


  if ( !is.null(from_x) && !sum(from_x %in% colnames(x))){
    stop("from_x must be found in x")
  }
  if ( !is.null(from_x) && sum(from_x %in% colnames(y)) && sum(from_x %in% colnames(x)) ){

    if (sum(by %in% from_x)){
      if (PRINT) message(from_x[which(from_x %in% by)], ' shall be deleted from from_x as they are in the index')
      from_x = from_x[-which(from_x %in% by)]

    } else if (length(from_x)){
      if (PRINT) message(from_x, ' are from x')
      y = deletenames(y,from_x)
    }
  }

  if ( !is.null(by) &&
       (str_length(names(by)) > 0) %>% sum # has at least one name
  ){

    place_name = str_length(names(by)) > 0 # which element has name?

    by_with_name = by [place_name] # select those elements with name

    for ( i in 1:length(by_with_name)){
      # i =1

      #1  change the names in y to id_x
      colnames(y)[which(colnames(y) == by_with_name[i])] =  names(by_with_name[i])
      # head(x2) ;  head(x) ; head(expand_data)
    }

    #2 change the value in "by" from id_y to id_X
    by[place_name] = names(by)[place_name]

  }
  #   join(x =x2, y = y, by = by)

  # only observations in x that meet constraint.x can be matched

  if (!is.null(constraint.x)){
    x[,"constraint.x"] = subset2_(df = x,condition = constraint.x, position = T)
    y[,"constraint.x"] = 1
    by = c(by,"constraint.x")
  }

  if (!is.null(constraint.y)){
    y[,"constraint.y"] = subset2_(df = y,condition = constraint.y, position = T)
    x[,"constraint.y"] = 1
    by = c(by,"constraint.y")

  }

  #   colnames(x)
  #   colnames(y)
  #
  #   duplicated(colnames(y))
  #   duplicated(colnames(x))
  #
  #


  x = cbind(x,tracking_x_placeholder = 1)
  y = cbind(y,tracking_y_placeholder = 1)


  test = plyr::join(x =x, y = y, by = by, type = type, match = match)

  test = deletenames(test,c("constraint.x","constraint.x"),PRINT = F)

  #______ deal with duplicated names __________

  # identify the duplicated names
  ## note that the from_y argument will overwrite any duplicated names.
  dup_names = colnames(test)[duplicated(colnames(test))]

  if (PRINT && length(dup_names)){
    message("\n duplicated column names generated: ")
    print(dup_names)
  }

  if (length(duplicate) && length(dup_names)) {

    Names = colnames(test)
    to_be_deleted =NULL

    for ( i in dup_names){
      # i = dup_names[1]

      dup_position = which( Names %in% i)

      # if numeric, then add them up
      if (duplicate =='add' && class(test[,dup_position[1]]) %in% c('numeric','integer')  ) {
        test[,dup_position[1]] = rowSums(test[,dup_position],na.rm=T)
      }

      if (duplicate =='suffix'){
        colnames(test)[dup_position[1]] = paste(colnames(test)[dup_position[1]],'_x',sep='')
        colnames(test)[dup_position[2]] = paste(colnames(test)[dup_position[2]],'_y',sep='')

      }

      # if character, then collapse them
      if (duplicate =='add' && class(test[,dup_position[1]]) %in% c('character','factor')  ) {
        test[,dup_position[1]] =apply(test[,dup_position],1,paste,collapse='  ')
      }

      if (duplicate =='copy'){
        NA_position = is.na(test[,dup_position[1]]) |  is.null(test[,dup_position[1]])
        test[NA_position,dup_position[1]] = test[NA_position,dup_position[2]]
      }

      if (duplicate =='replace' ){

        if (
          is.null(replace_var) || # if replace_var is not defined, then replace all dup vars
          i %in% replace_var # if replace_var is defined, then only replace dup vars in replace_var
        ){
          message(colnames(test)[dup_position[1]], " will be replace by y")
          y_places = !is.na(test$tracking_y_placeholder)
          test[y_places,dup_position[1]] = test[y_places,dup_position[2]]
        }


      }



      # only leave the first duplicated column.

      # accumulate the to_be_deleted
      to_be_deleted = c(to_be_deleted,dup_position[-1] # -1 means the last element
      )
    }
    if (duplicate !='suffix') test = test[,-to_be_deleted]
  }

  test = deletenames(test,c("tracking_y_placeholder","tracking_x_placeholder"), PRINT = F)


  return(test)

  if (F){

    ## UNIT TEST Code :

    Table1 = data.frame(A =c('x','y','z'),B = c(1:3), C=c(11:13))
    Table2 = Table1
    Table2[,2:3] = -Table2[,2:3]

    Join (x= Table1,y = Table2,by = c('A'),type = 'left',duplicate = 'add')
    Join (Table1,Table2,by = c('A'),type = 'left',duplicate = 'delete')
    Join (Table1,Table2,by = c('A'),type = 'left',duplicate = NULL)

    # get the first year of each team
    first <- ddply(baseball, "id", summarise, first = min(year))
    setnames(first,"id","ide_1")

    head(baseball)

    head(first)

    #  join when names in x and y are different
    Join(x = baseball, y = first, by = c("id"="ide_1"))

    # join only when the team's name is 'RC1' in x
    Join(x = baseball, y = first, by = c("id"="ide_1"),
         constraint.x = c("team == 'RC1'")) %>% head


    # test the replace functionality


    A = data.frame(a = 1:10, b = 1:10/10, c = 1:10)
    B = data.frame(a = 3, b = 100, c = 10000)

    Join(A,B,by = 'a',duplicate = 'replace')
    Join(A,B,by = 'a',duplicate = 'replace', replace_var = 'b')


    # duplicate = 'add'  can deal with NA
    A[3,'c'] = NA

    Join(A,B,by = 'a',duplicate = 'add')

  }

}

list.named = function(...){
  # from attach_load_first.R
  # an extention of list: it will include the object names as the lsit names

  lazy_capture = lazy_dots(...)

  name = rep(NA,length(lazy_capture))

  for( i in 1:length(lazy_capture)){
    name[i] = lazy_capture[[i]]$expr %>% deparse
  }

  result = list(...)
  names(result) = name
  return(result)

  if  (F){
    a = 1:3
    list.named(a,c(2:10))

    list.named(NI2q_Q56_TS30, NI2q_Q67_TS30, walk_model)


    lazy_capture = lazy(c(NI2q_Q56_TS30,NI2q_Q67_TS30, walk_model))

    str_sub( "NI2q_Q56_TS30()",1,-3)




  }
}


c.named = function(...){

  # from attach_load_first.R
  # an extention of c(): it will include the object names as the sequence names

  result = list.named(...)
  cequence = c(...) # sequence to be outputed


  place = 0 # place of an item

  for( i in 1:length(result)){
    length_i = length(result[[i]])
    place = place + length_i

    # if an object has multiple objects, then not assign name
    # only assign name if it has one object
    if (length_i == 1) names(cequence)[place] = names(result)[i]
  }

  return(cequence)


  if (F){

    a = 'a'
    b = 'b'
    other = c('as','s')
    c.named(a, other, b)

  }
}


rbind.fill2 = function(named_list = list()){

  # an extention of rbind.fill: it will include the dataset names as the index varaible
  # input shall be a named list

  result = data.frame(nplace_holder_indexxxx = names(named_list)[1],named_list[[1]])

  for ( i in 2:length(named_list)){
    result = rbind.fill(result,
                        data.frame(nplace_holder_indexxxx = names(named_list)[i],named_list[[i]])
    )
  }
  result = setnames.copy(result,"nplace_holder_indexxxx","index")
  return(clean_dup_names(result))

  if (F){


    a = data.frame(x = c(1:4))
    b = data.frame(x = 7, y =1)
    rbind.fill2(named_list =list.named(a,b))

  }
}



cbind.deleteNULL = function(...){
  # same as cbind, but delete the NULL elements automatically

  args = list(...)
  icount = 0
  for (i in args){
    if (!is.null(i)){
      icount = icount+1
      if (icount == 1) { # initialize
        result =  i
      } else {
        result = cbind(result,i)
      }
    }
  }
  result
}

subset2_ <- function(df, condition,position = F) {

  # from attach_load_first.R

  # lazy evaluation version of subset.
  # conditions can be formula or string
  # from: https://github.com/hadley/lazyeval/blob/master/vignettes/lazyeval.Rmd

  r <- lazy_eval(condition, df)
  r <- r & !is.na(r)

  if ( position ) { result = r
  } else {
    result = df[r, , drop = FALSE]
  }

  return(result)

  if (F) {
    subset2_(mtcars, ~mpg > 31)
    subset2_(mtcars, quote(mpg > 31))
    subset2_(mtcars, "mpg > 31")
    subset2_(mtcars, "mpg > 31",position = T)
    subset2_(df = diamonds, condition = "color == 'E'")
  }
}

subset_multiple = function(df,
                           condition_v = NULL,
                           # multiple conditions in the format of vector of strings
                           # each element itself must be a condition like those in subset,
                           # but just in the format of string
                           position = F,
                           # whether to output positions that meet the codition, rather than the subset
                           condition_output = F # whether to output the condition as a single var appended to subset
){

  # from attach_load_first.R

  # similar as subset, but can apply multiple conditions in the string format at the same time
  # depend on subset2_

  # df = x

  if (is.null(condition_v) || is.na(condition_v) ) { # if no condition, then return the original set
    message("conditions contain NULL or NAs, original dataset is returned.")
    return(df)
  }

  if ( sum(condition_v %in% c("data.frame" ,"matrix"))){
    condition_v = condition_v[1,]
  }

  Subset = 0

  # combine all conditions into one big condition, using &
  condition_full = paste(condition_v,collapse = ") & (") %>% paste("(",.,")")

  # get the positions that meet the condition
  position_TF = subset2_(df,condition_full,position = T)

  if (position) {
    return(position_TF)
  } else if (condition_output){
    return(data.frame(df[position_TF,], condition_full))
  } else {
    return(data.frame(df[position_TF,]))
  }

  if (F){
    subset_multiple(df) %>% nrow(.) == nrow(df) # no condidtion applied
    subset_multiple(df = diamonds, condition_v = c(price = "price>=500",color = "color == 'E'"))
    subset_multiple(df = diamonds, condition_v = c(price = "price>=500",color = "color == 'E'"),position = T)
  }

}

var_to_value = function(Data_with_name, # data.frame
                        index = NULL,  # only choose certain variables
                        middle = ' == ', # what to put in the middle when combine colname and value
                        left = '(', # left of the newly combined string
                        right = ')', # right of the newly combined string
                        Colnames = NULL # new colnames, if null then use original colnames
){

  # from attach_load_first.R

  # for a data.frame, combine the colnames and their corresponding values together
  # then output a new data.frame, where new values are the combined original colnames and original values

  # often used to transform the indexed data to conditons that can be used in subset()
  # see example
  sanity_check(Data_with_name,Class = 'data.frame')
  colnames(Data_with_name) = paste(left,colnames(Data_with_name),right,sep='')

  for (i in 1:ncol(Data_with_name)){
    # if value is chracter, then put ' ' aroudn it
    if (sum(class(Data_with_name[,i]) %in% c("character","factor"))){
      Data_with_name[,i] = paste("'",Data_with_name[,i],"'",sep='')
    }
    Data_with_name[,i] =  paste(left,colnames(Data_with_name)[i],middle,Data_with_name[,i],right)
  }
  if (!is.null(Colnames)) colnames(Data_with_name) = Colnames

  return(Data_with_name)

  if(F){

    unique.comb(Data_to_Combine = diamonds, index = c('price   >    1000',"cut")) %>%
      var_to_value(.[, c('price   >    1000',"cut")])
  }

}


unique.comb = function(Data_to_Combine, # data
                       index = NULL, # index: can be vars, or conditions. must be in the format of string
                       unique_var = NA,
                       check_unique = F
                       # one of the vars, used to decide whether the index vars can identify unique values of that var
                       # see example
){
  # from attach_load_first.R

  # used to generate unique combinations of index

  if (is.null(index)){
    index = colnames(Data_to_Combine)
  } else {
    # see whether can match the colnames in Data_to_Combine
    sanity_check(index,fuzzy_match = Data_to_Combine)
  }

  index = unique(index)

  if (is.na(unique_var)){
    # head(Data_to_Combine)
    result = Data_to_Combine %>%
      group_by_(.dots = index) %>%
      summarise_(n = ~n()) %>% data.frame
    if (check_unique){
      if (sum(result$n !=1)) {
        stop("not unique!")
      } else {
        message("it is unique")
      }
    }
  } else {
    result = Data_to_Combine %>%
      filter_(paste("!is.na(",unique_var,")")) %>%
      group_by_(.dots =index) %>%
      summarise_(n = ~n(),
                 unique = paste("n_distinct(",unique_var,")")) %>%
      data.frame

    if(sum(result$n != result$unique)){
      warning("there are non unique values in the combination")
      if(check_unique){
        stop("not unique!")
      } else {
        message("it is unique")
      }
    }
  }


  colnames(result)[1:length(index)] = index

  return(result)

  if (F){

    unique.comb(diamonds,index = c('price>1000',"cut")) %>% head
    unique.comb(diamonds,index = c('price>1000',"cut"),unique_var = 'color') %>% head
    unique.comb(diamonds,index = c('color',"cut"),unique = 'price') %>% head
  }

}



ldply2 = function(x, # data
                  index = NA, # see unique.comb()
                  condition = NA, # requirement see subset_multiple()'s condition_v
                  unique_var = NA, # see unique.comb()
                  test = F,
                  func, # similar as function in ldply. here its first element must be the subset of the data
                  ...){

  # from attach_load_first.R

  # similar as ldply, bust save a lot of code
  # get the subset at one time, no need to write ldply(ldply(ldply(  subset(..,///))))

  # can loop across conditions:
  # ex: loop across the groups of color
  # c("color %in% c('E','D')",
  # "color == 'E'")

  # can also loop accross indexes: unique colors, or unique price>=500 (F and T)

  Output = ldply (condition, function(condition_v){ # for each condition group

    # x = diamonds
    # condition_v = NA; unique_var = NA

    # subset data
    x_subset = subset_multiple(x,condition_v= condition_v) # choose only one condition

    message("===================================")
    message(paste(condition_v,collapse = " & "))
    message("")

    # indexed summary
    index_summary = unique.comb(Data_to_Combine = x_subset, index =  index, unique_var = unique_var)

    ldply(1:nrow(index_summary),function(i){
      # i = 1

      # get the ith unique combination

      index_summary_i = index_summary[i,]

      # Transform the index language into condition language
      index_condition_i = var_to_value(Data_with_name = index_summary_i[,index,drop = F])
      # get the subset data correpsonding to index_summary_i and index_condition_i
      data = subset_multiple(x,condition_v = index_condition_i)

      if(test) assign("data",data,envir = .GlobalEnv)

      message(paste(index_summary_i,collapse = " & "))

      if (nrow(data)) {
        # automatically add the index
        result_func = func(data,...)
        # result_func = func(data = data, index = index_summary_i)
        # result_func = func(data = data)

        # delete any variables in reseult
        index_summary_i = deletenames(index_summary_i, colnames(result_func), PRINT = F)
        rownames(index_summary_i) = NULL

        cbind(condion = condition_v,index_summary_i,result_func)
      }
    })
  })

  if (sum(is.na(Output$condion) | is.null(Output$condion)) == nrow(Output)) {
    Output = deletenames(Output,"condion")
  }
  return(Output)

  if (F) {

    test = ldply2(x = diamonds,
                  index= c("price>=500","color"),
                  condition = c("color %in% c('E','F')","color == 'E'"),
                  func = function(data,... =NA){
                    mean(data$price,na.rm= T)
                  })
    test
    test$color %>% class

    # see this one!!!

    # Summarize a dataset by two variables
    dfx <- data.frame(
      group = c(rep('A', 8), rep('B', 15), rep('C', 6)),
      sex = sample(c("M", "F"), size = 29, replace = TRUE),
      age = runif(n = 29, min = 18, max = 54)
    )

    # Note the use of the '.' function to allow
    # group and sex to be used without quoting
    ddply(dfx,
          .(group, sex),
          summarize,
          mean = round(mean(age), 2),
          sd = round(sd(age), 2))

    ddply(dfx,
          c("group == 'A'", "sex == 'F'"),
          summarize,
          mean = round(mean(age), 2),
          sd = round(sd(age), 2))

  }

}



ldply0 = function(x, # data
                  index = NA, # see unique.comb()
                  condition = NA, # requirement see subset_multiple()'s condition_v
                  unique_var = NA, # see unique.comb()
                  test = F,
                  func, # similar as function in ldply. here its first element must be the subset of the data
                  ...){

  # from attach_load_first.R

  # similar as ldply, bust save a lot of code
  # get the subset at one time, no need to write ldply(ldply(ldply(  subset(..,///))))

  # can loop across conditions:
  # ex: loop across the groups of color
  # c("color %in% c('E','D')",
  # "color == 'E'")

  # can also loop accross indexes: unique colors, or unique price>=500 (F and T)


  index_summary = unique.comb(Data_to_Combine = x, index =  index, unique_var = unique_var)


  Output =ldply(1:nrow(index_summary),function(i){
    # i = 6
    # print(i)
    # get the ith unique combination

    index_summary_i = index_summary[i,]

    # Transform the index language into condition language

    Data_with_name = index_summary_i[,index,drop = F]

    data = x

    for (j in 1:ncol(Data_with_name)){
      # j = 5
      # print(j)
      tobematch = Data_with_name[j] %>% unclass
      name_tobematch = names(Data_with_name)[j]

      NA_places = is.na(data[,name_tobematch])

      if (!is.na(tobematch)){
        if (sum(NA_places)){
          data = data[!NA_places,]
          data = data[data[,name_tobematch] == tobematch,]
        } else{
          data = data[data[,name_tobematch] == tobematch,]
        }
      } else {
        data = data[NA_places,]
      }
    }

    # get the subset data correpsonding to index_summary_i and index_condition_i

    if(test) assign("data",data,envir = .GlobalEnv)

    message(paste(index_summary_i,collapse = " & "))

    if (nrow(data)) {
      # automatically add the index
      result_func = func(data,...)
      # result_func = func(data = data, index = index_summary_i)
      # result_func = func(data = data)

      # delete any variables in reseult
      index_summary_i = deletenames(index_summary_i, colnames(result_func), PRINT = F)
      rownames(index_summary_i) = NULL

      cbind(index_summary_i,result_func)
    }
  })


  return(Output)

  if (F) {

    test = ldply2(x = diamonds,
                  index= c("price>=500","color"),
                  condition = c("color %in% c('E','F')","color == 'E'"),
                  func = function(data,... =NA){
                    mean(data$price,na.rm= T)
                  })
    test
    test$color %>% class

    # see this one!!!

    # Summarize a dataset by two variables
    dfx <- data.frame(
      group = c(rep('A', 8), rep('B', 15), rep('C', 6)),
      sex = sample(c("M", "F"), size = 29, replace = TRUE),
      age = runif(n = 29, min = 18, max = 54)
    )

    # Note the use of the '.' function to allow
    # group and sex to be used without quoting
    ddply(dfx,
          .(group, sex),
          summarize,
          mean = round(mean(age), 2),
          sd = round(sd(age), 2))

    ddply(dfx,
          c("group == 'A'", "sex == 'F'"),
          summarize,
          mean = round(mean(age), 2),
          sd = round(sd(age), 2))

  }

}



ldply0.colSums = function(Data, index,
                          var_eop = NULL,
                          index_eop = NULL,
                          method_eop = c('sum','average','unique'),

                          var_bop = NULL,
                          index_bop = NULL,
                          method_bop = c('sum','average','unique'),

                          var_average = NULL,
                          var_sum = NULL,
                          test = T){

  # like data %>% group_by() %>% summarise(sum(),mean() etc)
  # but this function will keep the output var names as the original name
  # for example, it automatically does summarise(sales = sum(sales))

  # also you can specify the method of summarizing data:
  # sum, mean, or take the value at the end of period


  Data = data.frame(Data)
  if ( is.null(var_sum) &  is.null(var_eop) &  is.null(var_bop) & is.null(var_average)){
    stop('at leased provide one to be summairzed var through var_sum, var_bop, var_eop or var_average')
  }

  if ((is.null(index_eop) + is.null(var_eop)) == 1){
    stop('both index_eop and var_eop are needed at the same time')
  }
  if ((is.null(index_bop) + is.null(var_bop)) == 1){
    stop('both index_bop and var_bop are needed at the same time')
  }

  if (!is.null(index_eop) && length(index_eop)>1 ){
    stop('you can only provide one value in index_eop')
  }
  if (!is.null(index_bop) && length(index_bop)>1 ){
    stop('you can only provide one value in index_bop')
  }
  sanity_check(c(index_eop, index_bop, index, var_eop, var_bop, var_average, var_sum),exact_in_match = colnames(Data))

  method_bop = match.arg(method_bop)
  method_eop = match.arg(method_eop)
  # method_eop = method_eop[1]
  method_eop_foo = method_bop_foo = colSums
  if (method_eop == 'average') method_eop_foo = colMeans
  if (method_bop == 'average') method_bop_foo = colMeans

  output = ldply0(Data,index = index, test = test,
                  func = function(data){

                    if (!is.null(index_eop) ){
                      max_value = max(data[,index_eop])
                      max_place = which(data[,index_eop] == max_value)

                      if (method_eop == 'unique' && sum(max_place)>1){
                        stop('as method for method_eop = unique,\n the max ', index_eop, ' in the subset data can only have one unique row.')
                      }

                      value_eop = data.frame(
                        t(method_eop_foo(data[max_place, c(var_eop),drop = F], na.rm = T))
                      )

                      value_eop[,paste(index_eop,'_eop',sep='')] = max_value
                      dupnames = var_eop %in% c(var_average,var_sum,var_bop)
                      if (sum(dupnames)){
                        colnames(value_eop)[dupnames] = paste(colnames(value_eop)[dupnames],'_eop',sep='')
                      }

                    } else {
                      value_eop = NULL
                    }

                    if (!is.null(index_bop) ){
                      max_value = max(data[,index_bop])
                      max_place = which(data[,index_bop] == max_value)

                      if (method_bop == 'unique' && sum(max_place)>1){
                        stop('as method for method_bop = unique,\n the max ', index_bop, ' in the subset data can only have one unique row.')
                      }

                      value_bop = data.frame(
                        t(method_bop_foo(data[max_place, c(var_bop),drop = F], na.rm = T))
                      )

                      value_bop[,paste(index_bop,'_bop',sep='')] = max_value
                      dupnames = var_bop %in% c(var_average,var_sum,var_eop)
                      if (sum(dupnames)){
                        colnames(value_bop)[dupnames] = paste(colnames(value_bop)[dupnames],'_bop',sep='')
                      }

                    } else {
                      value_bop = NULL
                    }
                    if (!is.null(var_average) ){
                      value_average = data.frame(
                        t(colMeans(data[,(var_average),drop = F],na.rm = T))
                      )
                      dupnames = var_average %in% c(var_eop,var_sum,var_bop)
                      if (sum(dupnames)){
                        colnames(value_average)[dupnames] = paste(colnames(value_average)[dupnames],'_average',sep='')
                      }

                    } else {
                      value_average = NULL
                    }


                    if (!is.null(var_sum) ){
                      value_sum = data.frame(
                        t(colSums(data[,(var_sum),drop = F],na.rm = T))
                      )

                      dupnames = var_sum %in% c(var_eop,var_average,var_bop)
                      if (sum(dupnames)){
                        colnames(value_sum)[dupnames] = paste(colnames(value_sum)[dupnames],'_sum',sep='')
                      }

                    } else {
                      value_sum = NULL
                    }

                    cbind.deleteNULL(value_sum,value_average,value_bop,value_eop)

                  })


  return(output)

  if (F){
    head(txhousing)


    ldply0.colSums(Data = txhousing,
                   index = c('year'),
                   var_eop = 'sales',index_eop = 'month',
                   var_bop = 'sales',index_bop = 'month',
                   var_average = c('sales','volume'),var_sum = 'sales',method_eop = 'average')

    ldply0.colSums(Data = txhousing,
                   index = c('year'),
                   var_eop = 'sales',index_eop = 'month',var_average = c('sales','volume'),var_sum = 'sales',method_eop = 'unique')

  }



}



###  Data Clean Functions  -------------------
# _______________________________________________________________________



get_unmatched = function(a,b){
  # an attach_Load_First.R function


  # find unmatched elements between a and b

  a = a %>% unique
  b = b %>% unique
  a_not_in_b = a[is.na(match(a, b))]
  b_not_in_a = b[is.na(match(b, a))]
  list(
    'a_not_in_b' = a_not_in_b,
    'b_not_in_a' = b_not_in_a ,
    'a_not_in_b/a' = length(a_not_in_b)/length(a),
    'b_not_in_a/b' = length(b_not_in_a)/length(b)

  )

}


clean_pivot_var = function(x,Begin_Separator = NULL){
  # an attach_Load_First.R function

  # this function is to clean one var in the pivot table
  # normaly you see in the pivot table, key index values are not repreated in the same group
  # which leaves a lot of NA within a group
  # this function will fill those NA places

  NA_place = is.na(x)
  if (!is.numeric(x)){
    # if not numeric, then the NA place may be ""
    empty = (x == "")
    empty[is.na(empty)] = 0
    NA_place = NA_place + empty
  }

  new_Begin_Separator = NULL

  if (sum(NA_place)){

    # get the valid values and valid places
    unique_values = unique(x[!NA_place])
    valid_places = which(!NA_place & x %in% unique_values)

    for (i in 1:length(valid_places)){
      # i = 2
      # i = 1
      if (i == length(valid_places)) {
        # for the last iteration, choose the end of data as the end
        end = length(x)
      } else {
        end = (valid_places[i+1]-1)
      }

      begin = valid_places[i]
      if (i == 1) old_end = 1

      if ( !is.null(Begin_Separator) ) {

        new_begin = which(Begin_Separator == Begin_Separator[begin]) %>% min
        new_end = which(Begin_Separator == Begin_Separator[begin]) %>% max
        if (new_end<=end) end = new_end

        if (i == 1 & new_begin<=begin) {
          begin = begin
        } else if (new_begin<=begin){
          begin = max(old_end + 1,new_begin)
        }
      }

      x[begin:end] = x[valid_places[i]]
      old_end = end
    }
  }
  x
}

clean_pivot = function(data,only_string_col = T){
  # an attach_Load_First.R function

  # this function is to clean the inputed pivot table
  # normaly you see in the pivot table, key index values are not repreated in the same group
  # which leaves a lot of NA within a group
  # this function will fill those NA places
  sanity_check(data,Class = 'data.frame')

  result = NULL

  for (col in 1:ncol(data)){
    if ( !is.numeric(data[,col])) {
      # col = 1;result = NULL
      # col = 2
      # Begin_Separator = 1
      if (col == 1)      {
        result = clean_pivot_var(x = data[,col])
      } else {
        result = clean_pivot_var(x = data[,col],Begin_Separator = data[,col-1])
      }

      data[,col] = result
      message(colnames(data)[col], " is filled")

    }
  }
  data
}





clean_wide_data = function(x,delete_row =NULL ,delete_col = NULL,
                           special_name = NULL,
                           special_name_position = NULL,
                           tidy_colname = T, # depreaciated function
                           title_as_var = F,
                           check_rowname = F # whether treat the t(x)'s rowname as first col
){
  # an attach_Load_First.R function
  # clean the wide data, normally imported from excel

  # x = adv_3q15_old
  test = t(x)

  if (check_rowname & !is.null(rownames(test))
  ){
    Rowname = rownames(test)
    rownames(test) = NULL
    test = data.frame(Rowname,test)
  } else {
    rownames(test) = NULL
  }

  ## head(test)
  if (title_as_var) test = data.frame(colnames(x),test)


  if (!is.null(delete_row)) test = test[-delete_row,]
  if (!is.null(delete_col)) test = test[,-delete_col]


  # first row as the colnames
  colnames(test) = test[1,]
  colnames(test) = clean_col_names(colnames(test))

  test = test[-1,] # delete the first row

  if (!is.null(special_name)) colnames(test)[special_name_position] = special_name


  test = test %>% change_col_class(., delete_empty_vars = F)

  test
}





complete_data = function(data,additional_cols, template_data = NULL){
  Cols = colnames(data)
  for (i in additional_cols){
    if (!i %in% Cols) {
      data[,i] = 0
    }
  }
  data
}




### Change variable class =========



change_col_class = function(x,
                            delete_empty_vars = T,
                            empty_var_as_0 = T,
                            numeric_NA_as_0 = F,
                            roundto = NULL){

  # an attach_Load_First.R function

  # change the class of each variable to its appropriate classes
  # see example in the end

  # x = test
  name_reserve = colnames(x)


  x = x %>% data.frame

  NA_place = NULL
  for (i in 1:ncol(x)){
    # i = 4

    if (sum(is.na(x[i])) == length(x[,i]) ){
      # totally NA in this column
      NA_place = c(NA_place,i)
    } else if (class(x[,i]) %in% c("character","factor")) {
      x[,i] = str_trim(x[,i],'both')

      # if transform to numeric makes more NA, then they are character
      if ( sum(is.na(as.numeric(x[,i]))) > sum(is.na((x[,i])),na.rm=T)  ){
        x[,i] = as.character(x[,i])
      } else {
        if (numeric_NA_as_0) {
          x[,i] = NA0(as.numeric(x[,i]))
        } else {
          print(paste(colnames(x)[i], 'to numeric'))

          x[,i] = as.numeric(x[,i])
        }

        if (!is.null(roundto)){
          print(paste(colnames(x)[i], 'round to',roundto))

          x[,i] = round(x[,i],roundto)
        }
      }
    }
  }

  if (delete_empty_vars && !is.null(NA_place)) {
    x = x[,-NA_place]
    name_reserve = name_reserve[-NA_place]
  }

  if (empty_var_as_0 && !is.null(NA_place)) {
    x[,NA_place] = 0
  }



  colnames(x) = name_reserve
  return(x)

  if (F){
    # change the text that purely contains numbers into class numeric
    sample_data = data.frame(one=c(NA,NA),
                             two = c("1","2"),
                             three = c("31",".1"),
                             three = c("31","a.1"))

    col_class_change(sample_data)

    str_detect("11`2.","\\D") & str_detect("112.1","\\D")

    as.numeric(c(NA,"2A"))
  }
}




as.numeric.fuzzy = function(test){
  # an attach_first.R function

  # default as.numeric will return error if there is a value in the series cannot be coerced to numeric.
  # this function will return NA for non-coercable value.

  storage = rep(NA, length(test))

  for (i in 1:length(test)){
    storage[i] =tryCatch(as.numeric(test[i]),
                         warning = function(war){NA}
    )
  }
  return(storage)

  if ( F){
    as.numeric.fuzzy(c('asa','1.2','012'))
  }
}

as.numeric.fuzzy.df = function(data, max_row = 10, max_col = 10,
                               whole = F # whether use all the data, will overwrite max_row/col
){
  # an attach_first.R function
  # transform each cell!! of df into numeric
  # non-coercible cells will be NA

  if (whole){
    max_row = nrow(data)
    max_col = ncol(data)
  } else {
    max_row = min(max_row, nrow(data))
    max_col = min(max_col, ncol(data))
  }



  data = data[1:max_row,1:max_col]

  storage = matrix(NA,max_row,max_col)

  for (ivar in 1:ncol(data)){
    var = data[,ivar]
    storage[,ivar] = as.numeric.fuzzy(var)
  }
  storage = data.frame(storage)
  colnames(storage) = colnames(data)

  storage
}

which.df = function(x,data){

  # apply the condition x into each cell of data
  # if in that cell is T, then return that cells row and col numer
  # output is a data.frame with two cols: 'row' and 'col' for each True cells.

  x_code = deparse(substitute(x))

  if (!str_detect(x_code,'series')){
    stop("please use 'series' as the object of which()")

  }

  x = lazy(x)
  storage = data.frame()

  for (i in 1:ncol(data)){
    x_locgic = lazy_eval(x,list(series = data[,i]))
    which_x = which(x_locgic)
    if (length(which_x)){
      storage = rbind(storage,
                      data.frame(row = which_x,
                                 col = i))
    }
  }

  if (nrow(storage)){
    attr(storage,'min_row') = storage[which.min(storage$row),]
    attr(storage,'min_col') = storage[which.min(storage$col),]

    if ( float0(sum(attr(storage,'min_col') - attr(storage,'min_row'))) == 0){
      attr(storage,'robust_begin') = attr(storage,'min_col')
    }
  }

  return(storage)


  if ( F ){

    data = rbind(c(0,1,2,NA,3),
                 c(0,1,2,3,NA),
                 c(NA,1,2,3,NA))
    data
    result = which.df(is.na(series),data)

    attr(result,'min_row')
    attr(result,'min_col')

  }


}


which.numeric_start = function(Data){
  # for a dirty data drame: find the starting cell that is coercible to numeric for dirty data

  numeric_Data = as.numeric.fuzzy.df(Data)
  non_na_place = which.df(!is.na(series), numeric_Data)

  result = attr(non_na_place,'robust_begin')
  if (is.null(result)) stop('no robust starting point')
  result
}




###  Change Names/Vars/Values in certian Vars   ---------------------------------

setnames.copy = function(x, old_keys, new_keys, PRINT = T){

  # from attach_load_first.R

  # change names of variables.
  # similar as setnames, but setnames is to change names without copy the data,
  # here we force to copy the data, and generate a new dataset, and then change the names on the new dataset,

  # x = actual

  for (ii in 1:length(old_keys)){

    if ('data.frame' %in% class(x)) {
      position = (colnames(x) == old_keys[ii])
    } else {
      position = (names(x) == old_keys[ii])
    }

    if (position %>% sum){
      if (PRINT) message(paste("Name Changed:",old_keys[ii],"change to", new_keys[ii]))



      if ('data.frame' %in% class(x)) {
        colnames(x)[position] = new_keys[ii]
      } else {
        names(x)[position] = new_keys[ii]
      }

    } else {
      if (PRINT) message(paste("CANNOT find any colname matched with",old_keys[ii]))
    }
  }
  return(x)

  if(F){

    head(diamonds)
    setnames.copy(diamonds,"carat","Carat") %>% head
    setnames.copy(diamonds,"Carat","carat") %>% head

  }
}


setvalues.copy = function(data, variable, value_origin, value_new){
  # from attach_load_first.R
  # change the values that matchef

  if ( length(value_origin) != length(value_new)) stop('length(value_origin) != length(value_new)')
  if ( !variable %in% colnames(data)) stop(variable,' not in data')

  for (i in 1:length(value_origin)){
    positions = (data[,variable] == value_origin[i])
    if (sum(positions)){
      data[positions,variable] = value_new[i]
    }
  }

  return(data)


  if (F){
  }
}

deletenames = function(x,
                       to_be_delete = NULL, # vars to be deleted
                       fuzzy = F, # whether to use fuzzy match, see example
                       PRINT = T
){

  # from attach_load_first.R
  # output the dataset after delete certain vars

  # x = test
  # to_be_delete =c("constraint.x","constraint.x")


  if (fuzzy) {
    postion = str_detect(colnames(x) ,to_be_delete)
    y = x[,!postion,drop = F]
  } else {
    postion = colnames(x) %in% to_be_delete
    y = x[,!postion,drop = F]
  }

  # if x contains duplcated names, then those duplicated names will be changed in y
  # so this step will just replace names in y with the original names in x
  colnames(y) = colnames(x)[!postion]

  if (PRINT){
    if (sum(postion)){
      message(
        paste(colnames(x)[postion],collapse=', ')," :  deleted"
      )
    } else {
      message("cannot find name: ", to_be_delete )
    }
  }
  return(y)

  if (F) {
    diamonds %>% head
    deletenames(diamonds %>% head,to_be_delete = c("pric","cut"))
    deletenames(diamonds %>% head,to_be_delete = c("pric","cu"),fuzzy = T)
  }

}


add_var_before_var = function(data,add_var,before_var){
  # from attach_load_first.R

  # data = walk
  # before_var = 'season'

  before_var_position = which(names(data) == before_var)

  if ( length(before_var_position) == 0 ) stop("before var cannot be found in data")

  data = data.frame(
    data[,1:(before_var_position-1)],
    add_var,
    data[,before_var_position:(ncol(data))]
  )
  if (is.null(dim(add_var)) & is.null(names(add_var))){

    colnames(data)[before_var_position] = deparse(substitute(add_var))

  }
  data
}


add_name_before_name = function(data,add_var, before_var){
  # from attach_load_first.R

  # data = walk
  # before_var = 'season'

  before_var_position = which(names(data) == before_var)

  if ( length(before_var_position) == 0 ) stop("before var cannot be found in data")

  data = c(
    data[1:(before_var_position-1)],
    add_var,
    data[before_var_position:(length(data))]
  )

  if (is.null(names(add_var))){

    names(data)[before_var_position] = deparse(substitute(add_var))

  }
  data
}



###  Clean Names/colnames   ---------------------------------


clean_col_names =function(Names,check_dup = T, lower_cap = T, underscore_to_empty = F,
                          single_dot_to_empty = T, clean_na_names_ind = T){

  if (clean_na_names_ind) Names = clean_na_names(Names)

  if (lower_cap) Names = tolower(Names)

  for (i in 1:4) Names = str_replace(Names,"\\.\\.","")
  #   Names = str_replace(Names,"\\(\\%\\)","")
  #   Names = str_replace(Names,"\\(\\$\\)","")

  Names =str_trim(Names,side = "both")
  for (i in 1:9) {
    Names = str_replace(Names,"/","_")
    if (single_dot_to_empty) Names = str_replace(Names,"\\.","_")
    Names = str_replace(Names," ","_")
    Names = str_replace(Names,"-","")
    Names = str_replace(Names,"__","_")
    Names = str_replace(Names,"\\*","_")

  }


  Names = str_replace(Names,"_$","")
  Names = str_trim(Names,side = "both")

  if (underscore_to_empty)  Names = str_replace_all(Names,"_"," ")


  if (clean_na_names_ind) Names = clean_na_names(Names)
  if (check_dup) Names = clean_dup_names(Names)

  Names
}


clean_na_names = function(x){
  # an attach_Load_First.R function

  # replace all na names as NA_name_i

  NA_T = is.na(x) | x == ''
  if(sum(NA_T)) {
    message("NA names are found")
    x[NA_T] = paste("NA_name_",1:sum(NA_T),sep = '')
  }
  x
}


clean_dup_names = function(x){
  # an attach_Load_First.R function

  # replace all duplicated names as name_i

  # x = c("a","b","a","b","c")

  dup_T = duplicated(x)

  if(sum(dup_T)) {

    xu = unique(x)
    xu_d = xu[xu %in% x[dup_T]]

    message("dupliacted names are found:")
    print(xu_d)
    for (i in xu_d){
      x[x == i] = paste(i,"_",1:length(x[x == i] ),sep='')
    }
  }
  x
}




standardize_names =
  function(non_stand_names = attr(total_4q15,"origin_names"),
           stand_names = NULL,
           sep = "_",
           output_type = c("max",'full')){

    # this function will try to match non_stand_names with stand_names
    # the method is:
    # 1.split each of stand_names into small elements
    # match those small elements with non-stand names to count non-stand names get the most
    # small elements matched

    output_type = match.arg(output_type)

    stand_names_list = str_split(stand_names,sep)
    names(stand_names_list) = stand_names

    store_match = data.frame()

    store_match =
      ldply(non_stand_names,function(i){
        ldply(stand_names_list,function(j){
          data.frame(non_stand_names = i, match = str_detect(tolower(i),tolower(j)) %>% sum)
        })
      })

    # ldply with named list will generate a ".id" column

    store_match = setnames.copy(store_match,".id","stand_names")

    matched_RA_names = ldply2(store_match,
                              index = 'stand_names',test = F,
                              func = function(data){

                                if (length(unique(data$match))>0){
                                  output = data[data$match==max(data$match),,drop = F]
                                  # if (nrow(output)>length(unique(data$non_stand_names))) message("non unique matching found in ", data$stand_names %>% unique)
                                }
                              })

    matched_RA_names = deletenames(matched_RA_names,"n")

    matched_RA_names = matched_RA_names[matched_RA_names$match>0,]

    matched_RA_names = unique.comb(matched_RA_names)
    matched_RA_names = deletenames(matched_RA_names,"n")


    if (output_type == 'max' &
        length(unique(matched_RA_names$non_stand_names))< nrow(matched_RA_names) ){

      matched_RA_names = ldply2(matched_RA_names,index = 'non_stand_names', func =function(data){

        data[data$match == max(data$match),]

      })
    }

    matched_RA_names = deletenames(matched_RA_names,"n")



    return(matched_RA_names)


    if (F){


    }
  }

standardize_names2 =
  function(non_stand_names = attr(total_4q15,"origin_names"),
           stand_names = NULL,
           sep_stand = "_",
           sep_non_stand = NULL,
           output_type = c("max",'full'),
           special_mapping = NULL ){

    # this function will try to match non_stand_names with stand_names
    # the method is:
    # 1.split each of stand_names into small elements
    # match those small elements with non-stand names to count non-stand names get the most
    # small elements matched

    output_type = match.arg(output_type)

    stand_names_list = str_split(unique(stand_names),sep_stand)
    names(stand_names_list) = unique(stand_names)

    store_match = data.frame()

    non_stand_list = as.list(unique(non_stand_names))
    if (!is.null(sep_non_stand)){
      non_stand_list = str_split(unique(non_stand_names),sep_non_stand)
    }
    names(non_stand_list) = unique(non_stand_names)


    store_match =
      ldply(names(non_stand_list),function(i){
        ldply(names(stand_names_list),function(j){


          print(i)
          print(j)
          # i = names(non_stand_list)[1]
          # j = names(stand_names_list)[1]

          # for each element of non-stand, see whether it is in stand

          result1 = ldply(clean_empty(non_stand_list[[i]]),function(ii){


            # see whether element of non-stand is in stand

            match_score = (
              (str_detect(tolower(j),tolower(ii)) * str_length(tolower(ii)))
              %>% sum
            )/2/length(non_stand_list[[i]])

            if (!is.null(special_mapping) && ii %in% names(special_mapping)){
              ii = special_mapping[names(special_mapping) == ii][1]
              match_score = match_score +
                (
                  (str_detect(tolower(j),tolower(ii))* str_length(tolower(ii))) %>% sum
                )/2/length(non_stand_list[[i]])
            }
            if (match_score>0) data.frame(i,j,ii,match = match_score)
          })
          # for each element of stand, see whether it is in non-stand

          reult2 = ldply(clean_empty(stand_names_list[[j]]),function(jj){
            match_score =  sum(str_detect(tolower(i),tolower(jj)) * str_length(tolower(jj)))/2/length(stand_names_list[[j]])

            if (!is.null(special_mapping) && jj %in% special_mapping){
              jj = names(special_mapping)[special_mapping == jj][1]
              match_score = match_score + sum(str_detect(tolower(i),tolower(jj))* str_length(tolower(jj)) )/2/length(stand_names_list[[j]])

            }
            # jj = stand_names_list[[j]][1]
            if (match_score>0) data.frame(i,j,jj,match = match_score)
          })
          rbind.fill(result1,reult2)
        })
      })

    # ldply with named list will generate a ".id" column

    store_match = setnames.copy(store_match,c("i","j"),c("non_stand_names","stand_names"))

    store_match =
      store_match %>% group_by(non_stand_names,stand_names) %>%
      summarise(match = sum(match,na.rm=T)) %>% data.frame


    matched_RA_names = ldply2(store_match,
                              index = 'non_stand_names',test = F,
                              func = function(data){

                                if (length(unique(data$match))>0){
                                  output = data[data$match==max(data$match),,drop = F]
                                  # if (nrow(output)>length(unique(data$non_stand_names))) message("non unique matching found in ", data$stand_names %>% unique)
                                }
                              })

    matched_RA_names = deletenames(matched_RA_names,"n")

    #   matched_RA_names = matched_RA_names[matched_RA_names$match>0,]
    matched_RA_names = join( matched_RA_names , unique.comb(matched_RA_names[,c('non_stand_names'),drop=F]), by ='non_stand_names')

    #
    #     if (output_type == 'max' &
    #         length(unique(matched_RA_names$non_stand_names))< nrow(matched_RA_names) ){
    #
    #       matched_RA_names = ldply2(matched_RA_names,index = 'non_stand_names', func =function(data){
    #
    #         data[data$match == max(data$match),]
    #
    #       })
    #     }



    return(matched_RA_names)


    if (F){

    }
  }



###  Regular Expression -----------------------

paste2 = function(...){
  # paste witout sep
  # attach_Load_First
  paste(...,sep='')

}

paste_comma = function(...){
  # paste each item like English
  #   > paste_comma('a','b')
  #   [1] "a and b"
  #   > paste_comma('a','b','c')
  #   [1] "a, b and c"


  # attach_Load_First

  txt = c(...)
  L = length(txt)
  if (L ==0) stop('len cannot be 0')
  if (L ==1) return(paste(txt))
  if (L ==2) {
    return(paste(txt, collapse = ' and '))
  } else {
    first_n_1 =  txt[1:(L-1)]
    return(paste(first_n_1,collapse = ', ') %>% paste(.,txt[L], sep = ' and '))
  }

  if (F){
    paste_comma('a','b')
    paste_comma('a','b','c')
  }
}



str_detect_multiple = function(x,pattern,wrong_pattern = NULL, any = F){

  Store = rep(0,length(x))
  for (i in pattern){
    # i = pattern[2]
    Store = str_detect(x,i) + Store
  }
  result = (Store == length(pattern))

  if (any)   result = Store >0

  if (!is.null(wrong_pattern)) {

    Store_wrong = rep(0,length(x))
    for (i in wrong_pattern){
      # i = pattern[2]
      Store_wrong = str_detect(x,i) + Store_wrong
    }
    result_wrong = Store_wrong>0

    if (sum(result_wrong)) result[result_wrong] = F
  }



  return(result)


  if ( F) {
    str_detect_multiple("321 345 DD",c("321","345"))
    str_detect_multiple("321 345 DD",c("321","245"))
    str_detect_multiple("321 345 DD",c("321","245"),any = T)

    str_detect_multiple("321 DD","321",wrong_pattern = 'DD')
  }
}



str_extract_multiple = function(x,y){
  result = rep(NA,length(x))
  for (i in y){
    matched_i = str_extract(x,i)
    na_place_last_time = is.na(result)
    result[na_place_last_time] = matched_i[na_place_last_time]
  }
  return(result)

  if(F){


    Names = c("subTS31_66_essbase", "product", "measures", "Yr.2010.Jan",
              "Yr.2010.Feb", "Yr.2010.Mar", "Yr.2010.Apr", "Yr.2010.May", "Yr.2010.Jun",
              "Yr.2010.Jul", "Yr.2010.Aug", "Yr.2010.Sep", "Yr.2010.Oct", "Yr.2010.Nov",
              "Yr.2010.Dec", "Yr.2011.Jan", "Yr.2011.Feb", "Yr.2011.Mar", "Yr.2011.Apr")
    match.fuzzy(Names, month.abb)



  }

}

str_changeline = function(x,L = 10,tobereplaced = c('(_| )')){
  # change line within long names longer than L

  y = x
  for (ii in 1:length(y)){

    y[ii] = str_trim(y[ii],'both')

    if ( str_length(y[ii])>=10) {
      y[ii] = str_replace_all(y[ii],tobereplaced,'\n')
    }
  }
  return(y)

  if(F){
    long_names = c('sfsdf_dfsdfsf','afsdfsf_judgement','dfs_sd','propsed_fsdfdfs','1 2')
    str_changeline(long_names)
  }

}

print_percent = function(x, digits = 2){
  paste(sprintf(paste("%.",digits,"f",sep=''),x),"%",sep='')
}



str_reverse = function(x){
  result = c()
  for (i in 1:length(x)){
    result[i] = strsplit(x[i],NULL)[[1]] %>% rev() %>% paste(.,collapse = '')
  }
  return(result)

  if (F){
    str_reverse(c('2a','2c'))
  }
}



print_millions = function(x,
                          digits = 2,numeric = F,
                          comma = T,dollar_sign = T,
                          postfix = 'm', dollar_divide = 10^6){

  if (is.na(x)) return (x)

  numeric_result = round(x/dollar_divide*10^digits)/10^digits

  if (!numeric){

    character_result = paste(sprintf(paste("%.",digits,"f",sep=''),x/dollar_divide),postfix,sep='')

    if (comma){
      inter_part_length = str_length(round(numeric_result))
      fraction_part = str_sub(character_result,inter_part_length+1,str_length(character_result))

      character_result =
        comma_number_needed = round(inter_part_length/3) + 1
      List = NULL

      integer_part = as.character(round(numeric_result))


      rev_integer_part = str_reverse(integer_part)

      for (i in 1:comma_number_needed){
        # i = 1
        List[i] = str_sub(rev_integer_part,
                          1 + (i-1)*3 ,
                          3 * i)
      }
      List = unlist(List)
      List = List[List!='']
      inter_part = str_reverse(paste(unlist(List),collapse = ',') )

      character_result = paste(inter_part,fraction_part,sep='',collapse = '')

    }

    if (dollar_sign ) character_result = paste("$",character_result,sep='',collapse = '')

    return(character_result)

  } else {

    return(numeric_result)

  }

  if (F){

    print_millions(2121310899)
    print_millions(2121310899,digits = 5)
    print_millions(212131089321312319)
    print_millions(212131089321312319)

  }


}


print_billions = function(...){

  return(print_millions(postfix = 'bn', dollar_divide = 10^9,...))


  if (F){

    print_billions(212131089321312319)
    print_millions(212131089321312319)

  }

}




combine_items = function(data,
                         item_name,
                         search_words = "rew|share|sharing", # could be a sequence, which means AND
                         print_data = T){


  # from attach_load_first.R

  # sum up certain vars into one var
  # we serch related vars with key words search_words, and then combine them into var :item_name


  message("\n ",item_name," related items")
  items =   colnames(data)[str_detect_multiple(x = colnames(data),pattern = search_words)]


  # data[,items]

  print(items)


  if (length(items)>1){
    sum_items = rowSums(data[,items],na.rm =T)
  } else if (length(items)==1){
    sum_items = data[,items]
  } else {
    stop("cannot find any related items")
  }

  data[,item_name] = sum_items

  if ( print_data){

    print(head(data[,c(items,item_name)]))

  }

  invisible(data)
}



###  Sanity Checks  -------------------
# _____________________________________________________________________________

complete.col = function(Data){

  # from attach_load_first.R

  # check missing values in each coloumn

  ldply(1:ncol(Data),function(x){
    data.frame(colnames = colnames(Data)[x],
               missing_freq = sum(is.na(Data[,x]))
    )
  })
}

complete.row= function(data_to_check){

  # from attach_load_first.R

  # check missing values in each row

  # there are some vars
  # 1. nrow: number of row that contain missing iterms
  # 2. ncol_missing: how many cols are missing
  # 3. total_missing: whether the whole row is missing

  total_ncol = ncol(data_to_check)
  cat("\n total_ncol: ", total_ncol, "\n")

  ldply(1:nrow(data_to_check),function(i){

    # i =1
    to_be_checked = data_to_check[i,] %>% unlist(as.list(.))
    ncol_missing = (is.na(to_be_checked) | is.nan(to_be_checked) | is.null(to_be_checked))  %>% sum

    if (ncol_missing) {
      data.frame(nrow = i,
                 "ncol_missing" = ncol_missing,
                 "total_missing" = (ncol_missing == total_ncol)
      )
    }

  })
}

check_vec_meaningful = function (x){

  # an attach_Load_First.R function

  # this function will check whether the vector is NULL or all values of it are NA NULL or NaN,
  # but we do allow logic(0) and integer(0)

  if (is.null(x) || length(x)==0) { # is.null will check the object as a whole, not each single element
    y = 0
  } else if ( !is.vector(x) || class(x)=='list') { # is.vector will return true for list and vector!
    stop('x is not a vector, it might be a list or data.frame or matrix ....')
  } else if (sum(is.na(x) + is.nan(x)  )==length(x) ){ # this method will allow logic(0) and integer(0)
    y = 0
  } else {
    y = 1
  }

  return(y)

  if (F){

    check_vec_meaningful(c(NA,NA)) # NOT PASS
    check_vec_meaningful(x=list(NA,NaN)) # NOT PASS
    check_vec_meaningful(c(NA,1)) # PASS
    check_vec_meaningful(c(NULL,1)) # PASS

  }
}

check_single_numeric = function(x, sign = 1){

  # an attach_Load_First.R function
  # check whether an object is a single numeric number

  if (sum(c('numeric','integer','logical') %in% class(x)) && length(x)==1 && x*sign>0) {
    x= 1
  } else {x = 0}

  return(x)

  if (F){
    check_single_numeric(x = nrow(diamonds))
  }
}

####  unit test


exist_col = function(data,col,joint = T){

  # test whether col names are in the data
  # will return 1 or 0

  result = NULL
  for (i in col){
    result[i] = i %in% colnames(data)
  }
  if( joint ) result = sum(result)
  result
}



# _____________________________________________________________



###  Model Functions  -------------------
# _______________________________________________________________________

# _____________________________________________________________

get_valid_rows = function(model, data ){
  # from attach_load_first.R

  # get the used rows i n the data for modelling
  data[,c(get_x(model,method = 'raw'), get_y(model,method = 'raw'))] %>% complete.cases
}

stripGlmLR = function(model) {

  # from attach_load_first.R

  # Trimming the Fat from glm() Models in R: reduce the size of it
  # http://www.r-bloggers.com/trimming-the-fat-from-glm-models-in-r/

  #' make the lm or glm thin
  #' @export
  #' @keywords internal
  #' @param model glm or lm.
  #' @return a thinner model
  #' @author  Nina Zumel

  model$y = c()
  model$model = c()

  model$residuals = c()
  model$fitted.values = c()
  model$effects = c()
  model$qr$qr = c()
  model$linear.predictors = c()
  model$weights = c()
  model$prior.weights = c()
  model$data = c()

  model$family$variance = c()
  model$family$dev.resids = c()
  model$family$aic = c()
  model$family$validmu = c()
  model$family$simulate = c()
  attr(model$terms,".Environment") = c()
  attr(model$formula,".Environment") = c()

  model$striped = TRUE



  return(model)


  if( FALSE && TRUE) {


    model = lm(price~  I(carat^   2) + cut  - carat:table - cut ,ggplot2::diamonds)

    model = stripGlmLR(model)

    model$residuals

    for (i in attributes(model)$names){
      print(model[[i]])
    }
  }

}




string_tidy = function(test_string,
                       Sep = "  ", # separator of words in the original strings
                       to_be_replaced = NULL,
                       replacing = NULL){

  # from attach_load_first.R

  # this code can make a series of string tidy,
  # by 1. deleting the empty spaces,
  # by 2. replacing the lengthy words by abbreviation.

  Replace = F   # by default, just clean the strings, not replacing,
  # if to_be_replaced & replacing is provided, then we do replacing!
  if (class(to_be_replaced) == 'character' &&  class(replacing) == 'character') Replace = T

  # ldply below will delete the additional spaces and do replacing if Replace = T
  labels_split = ldply(str_split(test_string, Sep), # separate each string into words
                       function(Row){

                         # Row = str_split(test_string, Sep)[[1]]

                         Row = str_trim(Row,side = "both") # delete the space both sides
                         Row = Row[!(Row %in% "")] # drop the empty words

                         # begin replacing!!!
                         j = 1
                         while (Replace == T &&  j<=length(Row)){

                           # j=1
                           # cat(j)
                           if (   Row[j] %in%  to_be_replaced  ) { # if find the to_be_replaced in the words, then replace it
                             Row[j] = replacing[to_be_replaced %in% Row[j] ]
                           }
                           j = j+1
                         }
                         Row
                       })

  #  Row =  c("PA"     ,     "DIRECT MAIL" ,"BT_DURATION"   )
  #  to_be_replaced = c("DIRECT MAIL" ,"BT_DURATION" ); replacing = c("DM" ,"BTD" )

  ## try to make each of the string the same length
  Length_Vector = apply(labels_split,2,function(string){str_length(str_trim(string))})
  Max_Length =  apply(Length_Vector,2,max)

  for (col in 1:ncol(labels_split)){
    for (row in 1:nrow(labels_split)){

      # col = 1; row = 6
      if ( is.na(Length_Vector[row,col]) || is.null(Length_Vector[row,col])) next

      labels_split[row,col] = str_trim(labels_split[row,col])

      if (Length_Vector[row,col]<Max_Length[col]) {

        # row = 300
        labels_split[row,col] = str_pad(labels_split[row,col],Max_Length[col],side='right' )
        # cat(labels_split[row,col])
        # cat(labels_split[row,])

      }
    }
  }
  result = apply(labels_split,1,function(i){
    # i =6
    paste(i,sep='',collapse = Sep)
  })

  return(result)

  if ( F) {

    test_string = c("PA  DIRECT MAIL  BT_DURATION ", "PA  DIRECT MAIL  BT_DURATION",
                    "PA  DIRECT MAIL  BT_LIFE", "PA  DIRECT MAIL  NO", "PA  DIRECT MAIL  PO",
                    "GE  DIRECT MAIL  BT_DURATION", "ITA  DIRECT MAIL  BT_DURATION",
                    "GE  GE  BT_DURATION")

    # TEST CODE
    string_tidy(c(  c("aa bbb"),
                    c("bbb bbbnnnn")),Sep=' ')
  }

}



formula.paste = function(x){
  # from attach_load_first.R
  # paste a formula into text

  return(gsub(" ","", deparse(formula(x),width.cutoff = 500)))

  if(F){

    formula.paste(price~carat +
                    cut)

  }
}

#
# str_replace_all("Id(q_status_last2*dq_status_last*dq_status)",
#                 "\\*dq_status(?![A-z0-9\\_\\.])",
#                 "")

######  Unit test
# formula.replace(Formula = price~carat + cut,tobe_replaced = '\\+cut',replacing = '',method="model")
# formula.replace(Formula = price~ I(carat*cut) + carat + cut,tobe_replaced = 'carat',replacing = '')

get_var_sign = function(result,concatenate = T){
  # from attach_load_first.R

  # INPUT is the result of an glm regression
  # output is a table with first col as variables, second col as their signs
  # first variable is always the dependent variable # second variable is usually intercept

  Coeff = summary(result)$coefficient
  if ( concatenate)  rownames(Coeff) = gsub(" ","",rownames(Coeff))

  # paste formula in one line as character
  Formula = deparse(formula(result),500)

  # get the target variable
  target_position_end = str_locate( Formula,'~')[1] # target variable must locate before the '~' in the formula
  Target_Variable = str_trim(str_sub( Formula,1,target_position_end-1))

  if ( concatenate) Target_Variable =  gsub(" ","",Target_Variable)

  Coeff_Table = data.frame(
    Variables = c(Target_Variable,rownames(Coeff)),
    Sign = c(NA,Coeff[,1]>0), # whether it is postive
    Coeff = c(NA,Coeff[,1])
  )

  # if not positive, then negative
  Coeff_Table$Sign[Coeff_Table$Sign==0] = -1

  rownames(Coeff_Table)=NULL
  Coeff_Table

  # unit test
  # get_var_sign(lm(price~carat+cut,diamonds))

}

get_x = function(result = diamond_lm, method = c("raw","model","coeff"),
                 exclude.intercept = T,  # whether to exlude intercept
                 exclude.y = T, # whether to exlude y
                 data = NULL,  # to replace "." in the model wiht vars in data.
                 perl = F, # when excluding or including certain strings, whether to use regular expression
                 joint_include = NULL,
                 union_include = NULL,
                 joint_exclude = NULL
){
  # from attach_load_first.R

  # if method = "raw": only get the raw var: you will get "x" instead of "log(x)" from formula y~log(x).
  # if method = "model": only get the raw var: you will get "x" instead of "log(x)" from formula y~log(x).
  # if method = "coeff": used for categorical variables, you will get
  # "cut.L"       "cut.Q"       "cut.C"       "cut^4"
  # instead of just cut
  # from lm(price ~ cut,data = diamonds)

  method = match.arg(method)
  if (is.null(data)) data=data.frame(DELETE_LATER.....123.= 0)
  # some formulas contain "." to represent all other vars in data.
  # if data is null, then "." has no meaning at all
  # so we want to delete it
  # just replace "." by "DELETE_LATER.....123." temporily, later we will delete it.
  # so this "DELETE_LATER.....123." is just a temp place holder

  if (method == "raw") {
    var = all.vars(formula (result))
    if (exclude.y == T) var = var[-1]
  }

  if (method == "model") var = terms(result,data = data) %>% attr(.,"factors") %>% colnames()
  if (method == "coeff") {
    var = model.matrix(result) %>% colnames()
    if (exclude.intercept) var = var["(Intercept)" !=var]
  }

  var = gsub(" ","",var)

  ## ???
  for (type in c("joint_include", "joint_exclude" ,"union_include")){

    to_be_test =eval(as.name(type))

    if (! is.null(to_be_test)){
      var_match = 0

      to_be_test = gsub(" ","",to_be_test)
      # include = c("carat","cut")
      for (x in to_be_test){
        # x = 'carat'
        if (perl == F) x= fixed(x)
        var_match = str_detect(var, x) + var_match
      }
      if (type == 'joint_include')   var_match = var_match == length(joint_include)
      if (type == 'joint_exclude')   var_match = var_match == 0
      if (type == 'union_include')   var_match = var_match>0
      var = var[var_match]
    }
  }

  return(var[var != "DELETE_LATER.....123."])

  if (F) {

    diamond_lm  = lm(price~  I(carat^   2) + cut  + carat*table ,diamonds)
    case_inf = glm(case ~ age + education , infert,family = "binomial")

    get_x(diamond_lm,method = 'raw')
    get_x(diamond_lm,method = 'raw',exclude.y = F)
    get_x(diamond_lm,method = 'model')
    get_x(diamond_lm,method = 'coeff')
    get_x(diamond_lm,method = 'coeff',exclude.intercept = F)

    # DOC:

    # only select variables that include all the elments in joint_include
    get_x(diamond_lm,joint_include = c("carat","table"),method = "model")

    # only select vars that include at least one element in union_include
    get_x(diamond_lm,union_include = c("carat","table"))
    get_x(diamond_lm,union_include = c("carat","table"), method = "model")

    # exclude vars that contain at most one element in joint_exclude
    get_x(diamond_lm,joint_exclude = c("carat","table"))

  }
}

get_y = function(Formula,method = c("raw","model","coeff")){
  # from attach_load_first.R

  # depend on get_x

  method = match.arg(method)
  if (method == "raw") {
    result = get_x(formula(Formula),exclude.y = F)[1]

  } else {
    Formula = gsub(" ","",deparse(formula(Formula),500))
    result = gsub("\\~.*","",Formula,perl = T)
  }

  return(result)

  if ( F ) {
    get_y(log(price) ~sdfsf + dsa ~dsad)
    get_y(log(price) ~sdfsf + dsa ~dsad, method = "coeff")
    get_y(log(price) ~sdfsf + dsa ~dsad, method = "model")
  }
}

get_x_all = function(Formula){
  # from attach_load_first.R

  # get all x together from the formula as a single formula, without y
  # see the example
  # depend on get_y and get_x

  y = get_y(Formula,"model")
  Formula = gsub(" ","",deparse(formula(Formula),500))
  return(gsub(paste(y,"~",sep=''),"",Formula,fixed = T))

  if(F){

    get_x_all(Formula = log(price) ~sdfsf + dsa ~ dsad +.)

  }
}

#
#
# ### unit test
#

focusing_var_coeff = function(model,focus_var_coeff = NULL,focus_raw_coeff = NULL,  intercept_include = T){

  # an attach_Load_First.R function

  # make any coeff except focus_var_coeff as 0
  replacement = model$coefficients # model = Result
  names(replacement) = gsub(" ","",names(replacement))

  if ( !is.null(focus_var_coeff)){
    sanity_check(focus_var_coeff, exact_in_match = get_x(model,method = "coeff") )
    focus_var_coeff = gsub(" ","",focus_var_coeff)
  }

  if ( !is.null(focus_raw_coeff)){
    sanity_check(focus_raw_coeff, exact_in_match = get_x(model,method = "raw") )
    focus_raw_coeff = gsub(" ","",focus_raw_coeff)
    focus_var_coeff = get_x(model,union_include = focus_raw_coeff, method = "coeff")
  }

  if (intercept_include) focus_var_coeff = c(focus_var_coeff,"(Intercept)")

  # focus_var_coeff = '(Intercept)'
  replacement[!names(replacement) %in% focus_var_coeff] = 0

  model$coefficients = replacement
  return(model)

  if (F){
    lm(price~ cut + carat + I(carat^2) + I(carat^3) + I(carat  * depth),diamonds) %>%
      focusing_var_coeff(.,c("I(carat^2)","carat"))
  }
}

Effects = function( model = diamond_lm3,
                    Data,
                    focus_var_raw=c('carat',"depth"), # must be the raw vars in the model
                    focus_var_coeff=NULL,   # must be the coeff vars in the model
                    focus_value = NULL,
                    # a list, each element of the list must have names in focus_var_raw, and contain at least 2 values of the key coeff vars
                    # at least 2 vlaues shall be provided, as we want to get the effects of it on the dependent
                    nonfocus_value = NULL,
                    # a list, each element of the list must have names in non focus_var_raw, and contain at most 1 values of the key coeff vars
                    # only one vlaue can be provided, as we want to fix those non focus vars.
                    transform_y = NULL, # a function on y (ex. log(y) )
                    PRINT = T,
                    Reverse = T, # when plot, whether to use reverse order in x-axis (ex. for balance_left)
                    bar_plot = NULL # choose bar plot or line plot
){

  # an attach_Load_First.R function

  # Main usage:: check the effects of the key raw variable (key_focus), focus_var_raw[1], on the dependent.
  # If focus_var_raw[2] exists, then we call it non-key focus raw var,
  # then we will check the effects of the first raw var under different values of the second raw.

  # the function will also check if the dependent vars is monotonic under different values of the key_focus
  # if focus_var_raw[2] exists, then we will check if it is monotonic under different values of focus_var_raw[2]

  # you can also focus on effects of key_focus (focus_var_raw[1]) through only certain coeff vars.
  # you need specify those coeff vars, focus_var_coeff in the arguments. then all other coeff vars unspecified will have coeff 0
  # by default, focus_var_coeff is null, which means we will check effect of key_focus on all coeff vars.

  # by default, effects of key_focus through its value seq(0.05,0.95,by = 0.05) quantitles will be shown.
  # you can also provid values of all raws through argument focus_value (for focus_var_raw), and nonfocus_value for non-focus var
  # by default, for all non-key non_focus raw vars, we assume their values are fixed at mean (if numeric) or mode (if factor or character) .

  # what is "raw var" / "model var" and "coeff var"
  # in price ~ I(carat * depth) + I(carat>1), carat and depth are raw, but not model var,
  # "model vars" here are "I(carat * depth)" and "I(carat>1)"
  # "coeff vars" here are "I(carat * depth)" and "I(carat>1)TRUE"
  # "coeff vars" only exist after running the model
  # "raw vars" and "model vars" exist when formula is created.

  # preg = model =  glm(case ~ I(age>35) + spontaneous, data = infert,family = "binomial")
  # Data = infert

  ### ------------------------   prepare

  all_raw_var = get_x(model)
  all_coeff = get_x(model,method = "coeff")
  y = get_y(model,"coeff")
  names(model$coefficients) = gsub(" ","",names(model$coefficients)) # standardized the names

  ### ------------------------   check

  sanity_check(focus_var_raw, exact_in_match = all_raw_var )
  sanity_check(Data)
  if (sum(colnames(Data) %in% all_raw_var) < length(all_raw_var)) stop("Data provided is missing some raw vars for this regression")

  if (length(nonfocus_value)) {
    sanity_check(nonfocus_value, Class = 'list')
    sanity_check(names(nonfocus_value), exact_in_match = all_raw_var)
    for (x in nonfocus_value){
      sanity_check(x, exact_length = 1, message_provided = "Only 1 value can be provided for each non focus vars")
    }
  }

  if (length(focus_var_raw)>2) stop("You can only focus on at most two variables")
  if (length(focus_value)) {
    sanity_check(focus_value, Class = 'list')
    sanity_check(names(focus_value), exact_in_match = all_raw_var )
    for (x in focus_value){
      sanity_check(x,min_oberserv = 2,
                   message_provided = 'The provided values for each focus raw var shall at least have to different values to enable monoton comparsion')
    }
  }

  if (length(transform_y)) sanity_check(transform_y, Class = 'function')

  ### ------------------------    values for non-focus varaibles

  #   llply(diamonds,function(x){
  #      print(paste( class(x),collapse=' '))
  #   })

  ##~~~~~~~~   get the mean or mode for all raw vars : used for prediction

  all_raw_values = list()
  for ( each_raw_var in all_raw_var) {
    x = Data[,each_raw_var]
    Class = paste( class(x),collapse=' ')

    if ( Class %in% c("numeric","integer")){
      all_raw_values[[each_raw_var]] = mean(x)
    } else {
      # for factor or character, we assume Mode
      all_raw_values[[each_raw_var]] = Mode(x)
    }
  }

  # if you provide the values to the non-focus vars, then replace the mean/mode by the provided ones.
  if (length(nonfocus_value)){
    for( x in names(nonfocus_value)){
      all_raw_values[[x]] = nonfocus_value[[x]]
    }
  }

  ### get the valueS for focus raw vars
  # if numeric:
  # get seq(0.015,0.95,0.3 ) quanttile values for the non-key focus vars
  # get seq(0.015,0.95,0.05 ) quanttile values for the key focus vars
  # if not : like factor
  # get the unique values

  is_factor_key  = c(1,1)
  names(is_factor_key) = focus_var_raw
  i=1

  for( x in focus_var_raw){
    # x = focus_var_raw[1]
    is_factor_key[x] = sum(c("factor","character") %in% class(all_raw_values[[x]] ))

    if (x %in% names(focus_value)) {   # if values are provided for focus variables
      all_raw_values[[x]] = focus_value[[x]]

    } else if ( # if not provided,
      is_factor_key[x]
    ){
      # for factors and characters, just get unique values
      all_raw_values[[x]] =  focus_value[[x]] = unique(Data[,x])
    } else if ( i== 2 & is_factor_key[1]) { # for numerics
      # if the first focus var is a factor/character, and second focus var is a numeric,
      # then we just don't need a very detailed quantitle for the second one
      # i = 2
      all_raw_values[[x]] =  focus_value[[x]] =   unique(quantile(Data[,x],seq(0.015,0.95,0.3 )))
    } else {
      all_raw_values[[x]] =  focus_value[[x]] =   unique(quantile(Data[,x],seq(0.015,0.95,0.05 )))
    }
    i = i + 1
  }

  # ________ prepare data for predict() _____________

  # this will keep the class
  modeled_data = Expand.grid(all_raw_values,stringsAsFactors = F)
  # modeled_data[,1] %>% class
  model_use = model

  # if you only focus the effects of certain coeff vars, then assign all other coeff vars to 0
  if (!is.null(focus_var_coeff)){
    model_use = focusing_var_coeff(model,focus_var_coeff)
  }

  # ------------------- Prediction ~~~~~~~~~~~~~~~~~~~~~~~~```

  # class(modeled_data[,focus_var_raw[1]])
  predicted =  data.frame(predict = predict(model_use,modeled_data,type='response'),
                          modeled_data)

  ###_____  check the monotonicty ________

  # when there is only one focus var: the key
  if (length(focus_var_raw) ==1 ) {
    predicted = predicted[order(predicted[,focus_var_raw[1]]),]
    monoton_increase = is.increase(predicted$predict)
    monoton_decrease = is.decrease(predicted$predict)
  }
  # when there are focus vars: the key and non-key, we check each the monoton effectt under each value of the non-key
  if (length(focus_var_raw) ==2 ) {

    predicted = data.table(predicted)
    predicted = setorderv(predicted, focus_var_raw[2:1]) %>% data.frame

    unique_key_focus = unique(predicted[,focus_var_raw[2]])

    monoton_increase = laply(unique_key_focus, function(x){
      is.increase(predicted[predicted[,focus_var_raw[2]] ==x, ]$predict)
    })

    monoton_decrease = laply(unique_key_focus, function(x){
      is.decrease(predicted[predicted[,focus_var_raw[2]] ==x, ]$predict)
    })

    names(monoton_decrease) = unique_key_focus
    names(monoton_increase) = unique_key_focus

  }

  # ------------------- For Plot ~~~~~~~~~~~~~~~~~~~~~~~~```

  plot_data = predicted

  # whether the target variable needs some tranform function?
  if (!is.null(transform_y)){
    plot_data$predict =  predicted$predict = transform_y(plot_data$predict)
  }

  # initialize the graph
  graph = NULL

  # if the key focus var only has at most 10 unique values, then transfer it to factor when plot
  if (PRINT){

    Length_Unique = plot_data[,focus_var_raw[1]] %>% unique %>% length

    if (is.null(bar_plot) && ("numeric" %in% class(plot_data[,focus_var_raw[1]]))
    ){
      bar_plot = F
    } else if ((is.null(bar_plot))) {
      bar_plot = T
    }

    if (bar_plot && Length_Unique<=10) {
      plot_data[,focus_var_raw[1]] = as.factor(plot_data[,focus_var_raw[1]])
      is_factor_key[1] = 1
    }

    # plot according to number of focus variables
    if (length(focus_var_raw) ==1 ) {

      if (bar_plot && is_factor_key[1]>0){
        # if it is a character, then use bar to plot
        graph =
          ggplot(plot_data) + geom_bar(aes_string(x=focus_var_raw[1], y = 'predict'),stat = "identity") +
          labs(y=y)
      } else {
        graph =
          ggplot(plot_data) + geom_line(aes_string(x=focus_var_raw[1], y = 'predict')) +
          labs(y=y)
      }
    }
    #

    if (length(focus_var_raw)==2) {

      Class_col = paste( class(plot_data[,focus_var_raw[2]]),collapse=' ')

      if (!is_factor_key[2]) { # transfer the secondary key into factor
        plot_data[,focus_var_raw[2]] = as.factor(plot_data[,focus_var_raw[2]])
      }

      if (bar_plot && is_factor_key[1] ){
        graph = ggplot(plot_data) + geom_bar(aes_string(x=focus_var_raw[1],
                                                        fill = focus_var_raw[2],
                                                        y = 'predict'),
                                             stat = "identity") +labs(y=y)

      } else {
        graph = ggplot(plot_data) +
          geom_line(aes_string(x=focus_var_raw[1], colour = focus_var_raw[2], y = 'predict')) +
          labs(y=y)
      }

    }

    if (Reverse && is_factor_key[1] == 0) graph = graph + scale_x_reverse() # factor cannot use reverse
    print(graph)
  }

  Coeff_table = data.frame(Var = names(model$coefficients) , value = model$coefficients)
  rownames(Coeff_table) = NULL

  return(list(
    Focus_values = focus_value,
    data_and_predict = predicted,
    summmary_glm = Coeff_table,
    Monoton_Increase = monoton_increase,
    Monoton_Decrease = monoton_decrease,
    Graph = graph
  ))

  if (F) {
    ##___ unit test ____

    # ~~~~~~~~~~~~~ Basic

    preg = reulst = glm(case ~ I(age>35) + spontaneous + I(age*spontaneous), data = infert,family = "binomial")

    #
    Effects(preg, focus_var_raw = 'age', focus_var_coeff = c("I(age>35)TRUE"),Data = infert,PRINT = T)

    Effects(preg, focus_var_raw = 'age', focus_var_coeff = c("I(age*spontaneous)"),Data = infert,PRINT = T)

    # ERROR
    Effects(preg, focus_var_raw = 'age', focus_var_coeff = c("age>35"),Data = infert,PRINT = T)

    diamond_lm3 = lm(price~ cut + carat + I(carat^2) + I(carat^3) + I(carat  * depth),diamonds) # a GLM
    Effects(model = diamond_lm3,Data = diamonds, focus_var_raw=c('carat'))
    #~~~~~~~~~~~~~  for categorical

    # diamonds$cut %>% unique
    Effects(model = diamond_lm3,Data = diamonds, focus_var_raw=c('cut'))

    #~~~~~~~~~~~~~  for double
    Effects(model = diamond_lm3,Data = diamonds, focus_var_raw=c('carat',"cut"))
    Effects(model = diamond_lm3,Data = diamonds, focus_var_raw=c('carat',"depth"))

    Effects(model = diamond_lm3,Data = diamonds, focus_var_raw=c("cut","carat"))

    #~~~~~~~~~~~~~ only fucus on certain values
    Effects(model = diamond_lm3,Data = diamonds, focus_var_raw=c('carat',"cut"),
            focus_var_coeff = c("I(carat^2)","cut.L","cut.Q","cut.C","I(carat*depth)"))

    # also to test the monoton
    Effects(model = diamond_lm3,Data = diamonds, focus_var_raw=c('carat',"cut"),
            focus_var_coeff = c("I(carat^3)","cut.L","cut.Q","cut.C","I(carat*depth)"))

    #~~~~~~~~~~~~~ Provided values
    # also to test the monoton
    Effects(model = diamond_lm3,Data = diamonds, focus_var_raw=c('carat',"cut"),focus_value = list(carat=seq(0.5,6,0.1)))

    # wrong examples
    Effects(model = diamond_lm3,Data = diamonds, focus_var_raw=c('carat',"cut"), focus_var_coeff = c("I(carat^2)","cut"))
    Effects(model = diamond_lm3,Data = diamonds, focus_var_raw=c('carat',"cut7897"))

    # _____________________________________________________________

  }
}

get_sigma = function(model){

  # an attach_Load_First.R function
  # get the sample estimate of the sigma of the OLS model

  # sigma^2 = (Y-\hat{Y})'\times(Y-\hat{Y}) / df

  # note that:  (length(model$residuals) - model$rank) == model$df.residual

  return(
    (sum(model$residuals^2) / (length(model$residuals) - model$rank))^0.5
  )

  if (F){
    lm(price~ cut + carat + I(carat^2) + I(carat^3) + I(carat  * depth),diamonds) %>% get_sigma
  }
}

get_prediction_error = function(model, train = F , bias_var = 0 ){

  # an attach_Load_First.R function
  # get the in-sample trainf the OLS model
  sigma =  get_sigma(model)

  if (train){
    out_of_sample_error = 0
  } else {
    out_of_sample_error = sigma
  }

  return(
    # this is the in-sample estimate error for an unbiased model
    (sigma^2/ length(model$residuals) * model$rank + out_of_sample_error^2 + bias_var)^0.5
  )

  if (F){
    model = lm(price~ cut + carat + I(carat^2) + I(carat^3) + I(carat  * depth),diamonds)

    model %>% get_train_error
  }
}

get_cov_beta = function(model){
  # an attach_Load_First.R function
  # get covariance matrix of coeff estimates

  X = model.matrix(model)

  return(
    solve(t(X)%*%X) * get_sigma(model)
  )

  if (F){
    lm(price~ cut + carat + I(carat^2) + I(carat^3) + I(carat  * depth),diamonds) %>% get_cov_beta
  }
}

random_coeff = function(model){
  # an attach_Load_First.R function

  # randomnize the coeff according to the cov matrix of coeff

  coeff = mvrnorm(1,
                  model$coefficients,
                  get_cov_beta(model))
  Predict = model
  Predict$coefficients = coeff
  return( Predict)
}



###  Algorithm Functions  -------------------




tree_one_node = function(data, condition , key = NULL){

  # from attach_load_first.R
  # separate the data into subsets by the condition vector

  if (is.null(key)) {
    key = colnames(data)
  }

  F_or_F = unique.comb(data,index = condition)
  full_condtion = var_to_value(Data_with_name = F_or_F[,condition,drop = F])

  result = ldply(1:nrow(full_condtion),function(i){
    # i = 1
    data.frame(full_condtion[i,1],
               F_or_F[i,1],
               subset_multiple(data,condition_v = full_condtion[i,1])[,key]
    )

  })
  colnames(result)[1] = paste('condition',"_",names(condition),sep='')
  colnames(result)[2] = paste(names(condition))
  colnames(result)[3:ncol(result)] = key
  result
}




Stepwise = function(DATA= infert,
                    Upper= DQ_Upper,
                    Family = NULL, # gaussian(link = "identity") for OLS
                    Direction = 'forward',
                    Base = NULL, # the overall base formula when Upper is a list # usually it can be the most naive formula: depedent ~ 1
                    Test_Suit = NULL, # test siut
                    PRINT = T,
                    STOP = F,
                    method = c("BIC")){
  # !!!! you have to use defmacro, not the normal functions, as normal functions have bugs:
  # stepAIC cannot find the development dataset.


  # this function enables Upper models as a list of models, and each step the stepwise AIC algorithm will only look
  # variables within eahc element of the list.
  # only after searching completes for all variables in that list, will will continue to
  # include variables in the next level in the search

  sanity_check(Upper,Class = c("formula","list"))
  sanity_check(Upper[[1]],Class = c("formula"))
  sanity_check(method,exact_in_match = c("AIC","BIC"))


  if (class(Upper)=='formula') Upper = list(Upper)

  # by pass the " invalid (do_set) left-hand side to assignment" bug in defmacro
  if (is.null(Base)) {
    Base2 = get_y(Upper[[1]],"coeff") %>% paste(.," ~1") %>%  as.formula
  } else (Base2 = Base)


  cat("dependent var: ", get_y(Base2,"raw"))


  if (is.null(Family)) {

    Unique_Values_L = DATA[,get_y(Base2,"raw")] %>% unique
    Unique_Values_L = Unique_Values_L[!is.na(Unique_Values_L)]

    if ( length(Unique_Values_L) > 2) {
      Family2 = gaussian(link = "identity")
    } else {
      Family2 = 'binomial'
    }
  } else {Family2= Family }

  cat("type of model: ", paste(Family2)[1])

  for (k in 1:length(Upper)){

    # k=1
    if (PRINT){
      cat("\n \n -------------------------------------------------------------- ")
      cat("         Begin to include variables below      \n")
      print(Upper[[k]])
      cat("-------------------------------------------------------------- \n \n ")
    }

    # colnames(DATA)
    # ??stepAIC

    if (method=='AIC') K_punish = 2
    if (method=='BIC') K_punish = log(nrow(DATA)); cat("BIC is used")
    if (k==1) Result = Upper[[1]]

    Result = stepwise2(object =  Result,data = DATA,family = Family2,
                       scope =list(upper = Upper[[k]],lower = Base2 ),k = K_punish,
                       trace = PRINT)

    # always use the lowest model as the lower boundary

    # for the test suit


    Old_Formula  = 1 # initialize
    New_Formula = 0 # initialize

    if (PRINT) {
      cat("\n\n"); print(summary(Result)$coeff)
    }
    if (STOP ) Enter_to_Continue()

    while (!is.null(Test_Suit) && Old_Formula != New_Formula ) {
      Old_Formula = formula.paste(Result)

      for (test_i in Test_Suit){
        if ( is.null(test_i$Monoton_to_Match)) test_i$Monoton_to_Match = 1
        if ( is.null(test_i$Reverse)) test_i$Reverse = T

        Result = deleting_wrongeffect (model = Result, focus_var_raw = test_i$focus_var_raw, Reverse =  test_i$Reverse,family = Family2,
                                       Monoton_to_Match = test_i$Monoton_to_Match,
                                       focus_var_coeff = test_i$focus_var_coeff,PRINT =  PRINT,data = DATA, STOP = STOP)
      }

      New_Formula = formula.paste(Result)
    }
  }

  if ( PRINT ) {
    return(Result)
  } else {
    return(invisible(Result))
  }

  if (F){
    ## UNIT TEST

    Upper_List = list(
      level_1 = case ~ .+spontaneous,
      level_2 = case ~ .+induced
    )
    Test_Suit_test = list(test = list(focus_var_raw = "spontaneous",Monoton_to_Match = -1))

    Stepwise(DATA = infert,
             Upper = Upper_List,Test_Suit = Test_Suit_test,
             PRINT = T,STOP = T)
  }



}


delete_insig =
  function(result, # must be the return of a glm, can use summary() function on it
           Sig_Cutoff = 0.01 # the largest sig level you can accept
  ){


    # this function will return a string
    # if there is insignifcant variable, it will delete that variable from the formula, and return a string format of that formula
    # if there is no insiginifciant variable, it will return 'Nothing Deleted'

    # note that this function cannot deal with insignificant intercept!


    # delete the intercept row
    Coeff = summary(result)$coefficient[-1,]

    Formula = deparse(formula(result),500)

    # get the target variable
    target_position_end = str_locate( Formula,'~')[1] # target variable must locate before the '~' in the formula
    Target_Variable = str_trim(str_sub( Formula,1,target_position_end-1))

    if ( nrow(Coeff)>=1 & max(Coeff[,4])>Sig_Cutoff ){
      To_be_deleted = which.max(Coeff[,4])
      To_be_deleted_Variable = attributes(To_be_deleted)$name
      cat("\n",To_be_deleted_Variable,  "has P_Value as", max(Coeff[,4]),", larger than", Sig_Cutoff,
          ". It shall be deleted. \n \n")

      Variables_Left = row.names(Coeff)[-To_be_deleted]
      Formula_New = paste(Target_Variable, "~",paste(Variables_Left,collapse = ' + '))

      cat("New formula is: \n \n")

      cat(Formula_New)
    } else {

      cat("\n Nothing Deleted \n")
      Formula_New = 'Nothing Deleted'
    }

    cat("\n ----------------------------------------------------------- \n")

    return(Formula_New)

    if (F){

      # unit test code

      Random_Y = rnorm(100)
      Random_Unif = runif(100)
      Random_X = Random_Y + Random_Unif
      Random_X_false = rnorm(100)

      result = lm(Random_Y ~ Random_X + Random_X_false)
      delete_insig(result)

    }
  }



###  Walk Plot Functions ####

walk_excel_color =
  function(
    a, # original level
    b # level after change
  ){

    # from attach_load_first.R

    # this function is to:
    # for one change, get the color (green,red) and value (A,B) of ONE stacked bar in an excel walk

    # basic tricks
    # absolute values of A and B must = b
    # A shall be the base, the one near 0
    # A is not necessarily the starting point



    # ___________________ Negative Change: b<=a ______________

    if ( a<=0 & b<=a & b<=0) {
      A = b-a
      B = a
      A_color = 'red'
      B_color = NA
    }

    if ( a>=0 & b<=a & b<=0) {
      A = a
      B = b
      A_color = B_color = 'red'
    }

    if ( a>=0 & b<=a & b>=0) {
      A =  b
      B = a-b
      A_color = 'red'
      B_color = NA
    }

    # ___________________ Positive Change: b >= a ______________

    if ( a<=0 & b>=0) {
      A = min(a,b)
      B = max(a,b)
      A_color = B_color = 'green'
    }

    if ( a>=0 & b>=a & b>=0) {
      A = a
      B = b-a
      A_color = NA
      B_color = 'green'
    }

    if ( a<=0 & b>=a & b<=0) {
      A = a-b
      B = b
      A_color = 'green'
      B_color = NA
    }
    data.frame(a,b,A,B,A_color,B_color)
  }


walk_excel = function(
  data , # see input data
  residual =T, # calculate the residual, the left part unexplained by changes
  expect_a_residule = F,
  tax = 0.38, # tax rate of changes, so the post tax change = change * (1-tax)
  levels = NULL # which items are considered as LEVELS, not CHANGES
){
  # from attach_load_first.R


  # this function is to:
  # for a series of changes, get the color and value of each stacked bar in walk in excel
  # it uses walk_excel_color()

  # input data must be a vector with names
  # you can speicify which elements are LEVELS, by default it is the First and Last elements
  # then the middle elements will be the CHANGES


  # Output:
  # data to help easy to draw walk in Excel

  # colors column: to tell you which bar shall have which color: for both the transparant bar and colored bar
  # bar chart boundary in excel


  if (!is.vector(data)) stop ("data must be a vector")
  if (is.null(names(data))) stop ("data must have names")
  if (sum(duplicated(names(data)))) stop ("data names are duplicated")
  if (sum(duplicated(names(data)))) stop ("data must have names")

  from = names(data)[1]
  to = names(data)[length(data)]

  levels = c(from,to,levels) %>% unique

  sanity_check(levels, exact_in_match = names(data) )

  end = length(data) # which(names(data) == to)

  # changes component must be between start position and end position
  # changes may be after tax number
  taxed = rep(0,length(data))

  data = data * (1-tax)
  # LEVELS shall have no tax
  data[names(data) %in% levels] = data[names(data) %in% levels]/(1-tax)

  storage = NULL

  for (i in 1:length(data)){ # for each change

    print(i)

    start_whole = which(names(data) %in% levels)
    if (sum(start_whole<i)) last_level = max(start_whole[start_whole<i])


    if (names(data)[i] %in% levels){
      A = data[i]
      B = 0
      B_color =  NA
      A_color = 'blue' # default colors of levels are blue

      storage = rbind.fill(storage,
                           data.frame(index = names(data[i]),
                                      A,B,A_color,B_color,
                                      a = 0,
                                      b = data[i],
                                      data = data[i])
      )


    } else if (i<=end-1){

      storage = rbind.fill(storage,
                           data.frame(index = names(data[i]),
                                      walk_excel_color(a = data[last_level:(i-1)] %>% sum,
                                                       b = data[last_level:i] %>% sum),
                                      data = data[i]
                           )
      )

      if (i == end- 1 && residual & sum(data[last_level:i]) != data[i+1]){
        # calculate the residual, the left part unexplained by changes

        residual_amount = sum(data[last_level:i]) - data[i+1]

        if (!expect_a_residule && float0(residual_amount)!=0) stop('there is a non-zero residule!')

        residual_color = walk_excel_color(data[last_level:i] %>% sum,data[i+1])

        storage = rbind.fill(storage,
                             data.frame(index = 'residual',
                                        residual_color,
                                        data = residual_color$b  - residual_color$a
                             )
        )

      }
    }
  }

  return(storage)


  if ( F ) {


    walk_NCL = c(-3779, -277,
                 210, -72.31, -3921.2)

    walk_excel(walk_NCL) # data must have names
    names(walk_NCL) = c("NCL_4q15_3.0", "NCL_model_change",
                        "NCL_macro", "NCL_mix", "NCL_1q16_3.1")

    walk_excel(data = walk_NCL,from = "NCL_4q15_3.0", to = "NCL_1q16_3.1")

  }
}


remove_0_walk_items = function(walk_model,
                               items_to_remove = c('residual','tax_rate'), # which items to remove
                               remove_all_0 = F # remove all 0 items
){

  # from attach_load_first.R
  # remove 0 items from walk_model, the output of walk_excel


  for (i in items_to_remove){

    if (sum(walk_model$index == i)){

      amount_i = subset(walk_model,index == i)$data
      if (float0(amount_i,0)== 0 | is.na(amount_i)) walk_model = subset(walk_model,index != i)
    }
  }

  if (remove_all_0){
    storage = NULL
    for (i in 1:nrow(walk_model)){
      # i = 6
      if (
        (is.na(walk_model[i,'data']) || float0(walk_model[i,'data'] ==0)) &

        (is.na(walk_model[i,'a'] - walk_model[i,'b']) ||
         float0(walk_model[i,'a'] - walk_model[i,'b'])==0)
      ){
        print(i)
        storage = c(storage,i)

      }
    }
    if (length(storage)>0) walk_model = walk_model[-storage,]
  }

  return (walk_model)

  if (F){


  }

}



walk_plot = function (data, # input shall be the output of walk excel
                      ylim = NULL, # plot limit in y axis, automatic if NULL
                      title = '', # title of graph
                      text_position = c("either","above","below"),
                      # where are the text will be located
                      # or above when bar is positive, below when bar is negative

                      text_adjust = 13,
                      # how far the text shall be away from the bar
                      color_shcedual = c(ublue , ugreen,  ured),
                      # default color schedual
                      # blue is for the level of begining and end
                      # red is for decreasing change
                      # green is for increasing change

                      nagative_bar_empty = F, # whether for level bar (not change bar) fill color is empty
                      clean_index = T, # whether to clean the index names
                      text_size = 13,
                      x_title = NULL,
                      ...

){
  if (sum(duplicated(data$index))) stop('index is not unique')


  # from attach_load_first.R

  # plot a walk in R
  # input shall be the output of walk excel()

  text_position = match.arg(text_position)
  #   text_position = text_position[1]
  #____________   color  ___________

  # color schedual, transformed from excel color schedual
  color = paste(data$A_color,data$B_color)
  color[str_detect(color, 'red')] = 'red4'
  color[str_detect(color, 'green')] = 'green4'
  color[str_detect(color, 'blue')] = 'blue4'

  data$color = color
  data$color = as.character(data$color)

  data$color_fill = data$color

  if (nagative_bar_empty && sum(data$color_fill == 'blue4' & data$A < 0)) {
    data$color_fill[data$color_fill == 'blue4' & data$A < 0] = NA
  }

  #____________ Level Bars _______________

  # we use color to find which one is the level bars

  levels_pos = str_detect(color,'blue')


  #____________ position of rectangular ___________
  # x

  data$xmin = c(1:nrow(data)) -0.25
  data$xmax = data$xmin + 0.5


  # y for CHANGES bars

  data$ymax = pmax(data$a, data$b)
  data$ymin = pmin(data$a, data$b)

  # y for LEVELs bars
  data$ymax[levels_pos] = pmax(data$data[levels_pos],0)
  data$ymin[levels_pos] = pmin(data$data[levels_pos],0)


  #____________ text ___________

  # text for CHANGE
  data$change = data$b -data$a
  # text for LEVEL
  data$change[levels_pos] = data$data[levels_pos]

  data$change = sprintf("%.0f",data$change)


  Index = unique(data$index) %>% as.character
  if ( clean_index ) Index = Index %>% clean_col_names(.,check_dup = F, lower_cap = F,underscore_to_empty = T,single_dot_to_empty = F, ...)

  if (text_position == 'either'){
    data$text_position = data$ymin - text_adjust
    data$text_position[data$data >0] = data$ymax[data$data >0] + text_adjust
  }
  if (text_position == 'above'){
    data$text_position = data$ymax + text_adjust
  }
  if (text_position == 'below'){
    data$text_position = data$ymin - text_adjust
  }



  #____________ Plot ___________
  color_shcedual_fill = color_shcedual
  unique_fills = unique(clean_empty(data$color_fill))

  if (

    length(unique_fills) < length(color_shcedual_fill)

  ){
    color_shcedual_fill = color_shcedual_fill[-length(color_shcedual_fill)]
  }

  Plot = ggplot(data) +
    geom_rect(aes(xmin = xmin ,
                  xmax = xmax, ymin = ymin,
                  ymax = ymax, fill = color_fill,color = color)) +
    scale_y_continuous(label = NULL, breaks = NULL) +
    scale_x_continuous(breaks = c(1:nrow(data)),
                       labels = Index) +
    utheme +

    scale_fill_manual(values =color_shcedual_fill,guide="none") +
    scale_color_manual(values = color_shcedual,guide="none") +

    theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust=0.2, size=text_size),
          plot.title = element_text(size = text_size)) +

    labs(y = 'million', x = x_title, title = title)+
    geom_text(aes(x= (xmin + xmax)/2, y = text_position, label = change) )

  # if adjust the plot limit in y direction
  if ( !is.null(ylim)){
    Plot = Plot +  coord_cartesian(ylim=ylim)
  }

  print(Plot)

  return(invisible(plot))


  if ( F ){

    walk_NCL = c(-3900, -239,
                 242, -82, -3600)

    names(walk_NCL) = c("fdaf", "afda",
                        "af", "afdsf", "adfsfasd")

    walk_NCL = walk_excel(data = walk_NCL, expect_a_residule = T)

    walk_plot(walk_NCL,ylim = c(-4500,-3500),text_position = 'either',
              text_adjust = 100, title = 'walk', text_size = 13)

  }
}




###  Stacked Bar Functions  -------------------
stacked_bar_prepare = function(data,
                               value_var,
                               grouping_var_horizontal, # names to divide bars horizontally
                               grouping_var_vertical, # names to divide bars horizentally
                               bar_wide = 0.5,
                               bar_distance = 2 # horizental distance of bars
){
  # from attach_load_first.R

  # Function: prepare the plot of stacked_bar
  # max_x and max_y and min_x and min_y for rectangular plot: geom_rect()


  data = data %>%
    arrange_(.dots = c(grouping_var_horizontal,grouping_var_vertical)) %>%
    group_by_(.dots = c(grouping_var_horizontal,grouping_var_vertical)) %>%
    summarise_(.dots =c(valuedasda = paste2('mean(',value_var,')')
    )) %>% data.frame

  data = setnames.copy(data,'valuedasda',value_var)


  data$max_y = data$min_y = data$min_y_percent =
    data$max_y_percent = data$percent = data$percent_text = 0

  grouping_var_value = data[,grouping_var_horizontal] %>% unique

  data$min_x = -bar_wide/2
  data$max_x = bar_wide/2

  for (i in grouping_var_value){

    # i = grouping_var_value[1]
    data_i_p = data[,grouping_var_horizontal] == i
    data_i = data[data_i_p,]

    data$max_y[data_i_p] =
      cumsum(data_i[,value_var]) # end of OS height

    data$min_y[data_i_p] =
      c(0,
        data$max_y[data_i_p][-sum(data_i_p)]
      ) # begining of OS height

    max_y_cohor = max(data$max_y[data_i_p])

    data$min_y_percent[data_i_p] = data$min_y[data_i_p]/max_y_cohor
    data$max_y_percent[data_i_p] = data$max_y[data_i_p]/max_y_cohor

    # percent
    data$percent[data_i_p] = data$max_y_percent[data_i_p] - data$min_y_percent[data_i_p]

    data$percent_text[data_i_p] =
      paste(sprintf("%.2f",(data$percent[data_i_p])*100),"%",sep='')


    data$min_x[data_i_p] = bar_distance * (which(grouping_var_value == i)-1) + -bar_wide/2
    data$max_x[data_i_p] = bar_distance * (which(grouping_var_value == i)-1)+ bar_wide/2
  }

  # text position $ left and right
  data$text_p = rep(c(-bar_wide,bar_wide),100)[1:nrow(data)]

  return(data)


  if (F){

    head(diamonds)
    test = diamonds %>% group_by (cut, color) %>% summarise(carat = sum(carat,na.rm=T)) %>% data.frame
    stacked_bar_prepare(diamonds, 'carat', 'cut','color')

    eval_arguments(
      stacked_bar_prepare(diamonds, 'carat', 'cut','color')
    )

  }

}


plot_labeled_stackbar =
  function(data,
           fill, # color fill

           # coordinate of rectangular
           xmin = 'min_x' ,
           xmax = 'max_x',
           ymin = 'min_y',
           ymax = 'max_y',

           # filled color # if NULL, then auto color
           fill_scale_values = NULL,

           # grouping var: how many bars horinzontally
           grouping_var_horizontal,

           # how far the label text shall be away from the bar
           text_adjust = 1.7,

           # whether to print value of the subbar on the subbar
           add_value_onbar = T,
           value_onbar = NULL, # value of each small stacked_sub bar  # will print on the bar
           value_onbar_size = 2, # font size

           # whether to print label of the subbar on the subbar
           add_label = T,
           label = NULL, # label of each small stacked-sub bar # will print beside the bar
           label_size = 3, # size of the label

           # whether to print label on the top of each horizental bar
           add_top_label = T,
           top_label = NULL,
           top_label_adjust = 10,


           # whether to print the plot
           PRINT = T,

           # limits of x-axis in plot
           # if null, then auto generate
           limits = NULL,

           y_scale_label = NULL, # y is "dollar" or "value'
           y_title = '', # title of y-axis
           x_title = '', # title of x-axis
           title = NULL # title of the whole graph
  ){

    # from attach_load_first.R

    # PLOT A STACKED BAR IN R
    # input shall be the output of stacked_bar_prepare()

    if (is.null(label)) label = fill
    if (is.null(value_onbar))  value_onbar = '(ymin + ymin)/2'

    data = data %>%
      arrange_(.dots = c(grouping_var_horizontal,fill)) %>% data.frame

    data = setnames.copy (data,
                          c(xmin,xmax,ymin,ymax),
                          c("xmin","xmax","ymin","ymax")
    )

    if (is.null(limits)){
      x_width = max(data$xmax - data$xmin)
      limits = c(min(data$xmin) - x_width*2,max(data$xmax) + x_width*2)
    }

    breaks_value = ((data$xmax + data$xmin)/2) %>% unique
    breaks_label = paste(unique(data[,grouping_var_horizontal]))


    if (is.null(limits)){
      x_width = max(data$xmax - data$xmin)
      limits = c(min(data$xmin) - x_width*2,max(data$xmax) + x_width*2)
    }

    # data[,fill] = as.character(data[,fill])

    Plot = ggplot(data) +
      geom_rect(aes_string(
        xmin = 'xmin' ,
        xmax = 'xmax',
        ymin = 'ymin',
        ymax = 'ymax', fill = fill),color = 'grey4')+
      scale_x_continuous(limits = limits,
                         breaks = breaks_value,
                         labels= breaks_label) +
      labs(y = y_title,x = x_title, title = title) +
      theme_bw()

    if (!is.null(y_scale_label)){

      if (y_scale_label == 'dollar'){

        Plot = Plot +
          scale_y_continuous(label = dollar)

      } else if (y_scale_label == 'percent'){
        Plot = Plot +
          scale_y_continuous(label = percent)
      } else if (y_scale_label == 'comma'){
        Plot = Plot +
          scale_y_continuous(label = comma)
      }
    }

    if ( add_label){
      Plot = Plot +
        geom_text(aes_string(x=   '(xmin + xmax)/2 + text_p*text_adjust',
                             y = '(ymax + ymin)/2', label = label),size = label_size)
    }

    if ( add_top_label){
      Plot = Plot +
        geom_text(aes_string(x=   '(xmin + xmax)/2',
                             y = '(ymax)+top_label_adjust',
                             label = top_label),size = label_size)
    }

    if (!is.null(fill_scale_values)){
      Plot = Plot + scale_fill_manual(values = fill_scale_values)
    }

    if( add_value_onbar ){
      Plot = Plot +
        geom_text(aes_string(x=  '(xmin + xmax)/2' ,
                             y = '(ymax + ymin)/2',
                             label = value_onbar),
                  size = value_onbar_size)
    }

    if (PRINT)  print(Plot)

    return(invisible(Plot))


    if (F){

      test = diamonds %>% group_by (cut, color) %>% summarise(carat = sum(carat,na.rm=T)) %>% data.frame
      test2 = stacked_bar_prepare(test, value_var = 'carat',grouping_var_horizontal =  'cut', grouping_var_vertical = 'color')
      plot_labeled_stackbar(test2,fill ='color',ymax = 'max_y_percent', ymin = 'min_y_percent', grouping_var_horizontal = 'cut')
      plot_labeled_stackbar(test2,fill = 'color',grouping_var_horizontal = 'cut')


    }
  }



### Data Visualization ---------------------

get_color = function(mode = 'predefined'){

  d=data.frame(c=colors(), y=seq(0, length(colors())-1)%%66, x=seq(0, length(colors())-1)%/%66)
  ggplot() +
    scale_x_continuous(name="",  expand=c(0, 0)) +
    scale_y_continuous(name="", expand=c(0, 0)) +
    scale_fill_identity() +
    geom_rect(data=d, mapping=aes(xmin=x, xmax=x+1, ymin=y, ymax=y+1), fill="white") +
    geom_rect(data=d, mapping=aes(xmin=x+0.05, xmax=x+0.95, ymin=y+0.5, ymax=y+1, fill=c)) +
    geom_text(data=d, mapping=aes(x=x+0.5, y=y+0.5, label=c), colour="black",
              hjust=0.5, vjust=1, size=3)


  if(F){




    color_main =
      rbind(
        c(red = 235/255,green = 0, blue = 0),
        c(red = 0,green= 242/255, blue = 0),
        c(red = 0,green = 0, blue = 245/255),
        c(red = 235/255,green = 242/255, blue = 245/255)
      ) %>% data.frame

    color_main$X_id = 1:4
    color_main$colors_id = c('r','g','b','background')

    ggplot(color_main) +
      geom_rect( mapping=aes(xmin= X_id,
                             xmax= X_id  + 0.5,
                             ymin=0, ymax=1,
                             fill=rgb(red,green,blue,max = 1)))  +
      scale_fill_identity() +
      scale_x_continuous(breaks = 1:4, labels = color_main$colors_id) +
      theme(panel.grid = element_blank(),
            panel.background = element_rect(fill = ublue))

  }
}




### Test ---------------------

# source("/Users/yangguodaxia/Dropbox/Tech/R/attach_Load_First.R")
