public virtual class NewCalculator Extends Find_Greater_Smaller {
    
     Public Integer A  {Get;Set;}
    Public Integer B    {Get;Set;}
    Public Integer Result  {Get;Set;}
    Public String Choice  {Get;Set;}
    
    Public Void Calc()
    {
        If(Choice=='Add')
        {
            Add();
        }
        Else if(Choice=='Sub')
        {
            Sub();
        }
        Else if(Choice=='Mul')
        {
            Mul();
        }
        Else If(Choice=='Div')
        {
            Div();
        }
        Else
        {
            Result = 0;
        }
    }
    
    Void Add()
    {
      Result = A+B;  
    }
     Void Sub()
    {
      Result = A-B;  
    }
     Void Mul()
    {
      Result = A*B;  
    }
     Void Div()
    {
      Result = A/B;  
    }


}