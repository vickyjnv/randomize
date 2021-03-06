import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'config/colors.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'globals.dart'as globals;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mock_data/mock_data.dart';
import 'APIs.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
randomNumber(BuildContext context){
    String result;
    final fromController=TextEditingController();
    final toController=TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context){
      return StatefulBuilder(
        builder:(context,setState){
      return AlertDialog(
        scrollable: true,
        actions: <Widget>[FlatButton(
          onPressed:(){
            Navigator.pop(context);
            fromController.clear();
            toController.clear();
          },
        child: Text("Done",style: TextStyle(fontSize:14),))],
        backgroundColor: AppColors.primaryWhite,
        title:Center(child: Text("Random Number",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
        content: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text("Draw From",style: TextStyle(fontWeight:FontWeight.w500),),
                TextField(
                  decoration: InputDecoration(
                  labelText:"Enter starting no",),
                  keyboardType: TextInputType.number,
                  controller: fromController,
                ),
                Padding(
                  padding: const EdgeInsets.only(top:18),
                  child: Text("To",style: TextStyle(fontWeight:FontWeight.w500)),
                ),
                TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                  labelText:"Enter end no",),
                  keyboardType: TextInputType.number,
                  controller: toController,                
                ),
                SizedBox(height:20),
                RaisedButton(       
                  onPressed:(){
                    if(fromController.text.length==0||toController.text.length==null)
                      { 
                        setState(() {
                          result='Text feild cant be empty';
                        });
                      }
                    else if(int.parse(fromController.text)>int.parse(toController.text))
                      { setState(() {
                        result='check your values';
                      });
                      }
                    else if(fromController.text.length>10||toController.text.length>10)
                      {
                        setState(() {
                          result="Max 10 digits allowed";
                        });
                      }
                    else
                    { Random random = new Random();  
                      setState(() {
                        result=(int.parse(fromController.text)+ random.nextInt(int.parse(toController.text)- int.parse(fromController.text))).toString();
            
                      });
                      print("$result");
                    }
                  },
                child:Text("Draw"),
                ),
                SizedBox(height:20),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("The Result:",style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:16,left:16,right:16,),
                  child:Container(
                    width: 200,
                    height: 40,
                    child: Center(child: Text(result==null?"":"$result",style: TextStyle(fontSize:18,fontWeight: FontWeight.bold,color: Colors.red),)),
                    color: Colors.black,),
                )    
                ]
              ),
            ),
          ),
        );
      }
    );
  }
);
}

  dice(BuildContext context){
    int num=1;
    List<int> randoms=[1,2,3,4,5,6];
    int total=0;
    const menuitems=<int>[1,2,3,4,5,6];
    final List<DropdownMenuItem<String>>_dropmenuitems=menuitems.map((int value) => DropdownMenuItem<String>(child:Text(value.toString()),value:value.toString(),)).toList();
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(context,setState){
            return AlertDialog(
              scrollable: true,
              actions: <Widget>[
                RaisedButton(
                  onPressed:(){
                    total=0;
                    for(int i=0;i<=5;i++)
                      {
                        randoms[i]=Random().nextInt(6) + 1;
                          if(i<num)
                          {
                            total=total+randoms[i];
                          }
                      }                    
                    setState(() {
                    });
                  },
                  child:Text("Roll it",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black)),
                  color: Colors.teal,
                  disabledColor: Colors.teal,
                ),
                SizedBox(width: 20,),                               
                FlatButton(
                  onPressed:(){
                    Navigator.pop(context);},
                  child: Text("Done",style: TextStyle(fontSize:18),)),
              ],
              backgroundColor: AppColors.primaryWhite,
              title:Center(child: Text("Roll The Dice",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              content: Center(
                child: Column(
                  children: <Widget>[
                    Text("How many dice you want to roll?",style: TextStyle(fontSize: 18),),
                    DropdownButton(
                      items:_dropmenuitems,
                      value: num.toString(),
                      iconDisabledColor: Colors.teal,
                      iconEnabledColor: Colors.teal,
                      style: TextStyle(color:Colors.teal,fontWeight:FontWeight.w500,fontSize: 18),
                      onChanged:(String value){
                        total=0;
                       setState(() {
                        num=int.parse(value);
                        for(int i=0;i<num;i++)
                          {
                            total=total+randoms[i];
                          }
                      });
                      }
                    ),
                    howMany(randoms,num),
                    SizedBox(height:10),
                    Text("Dice Total:$total",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.w500),)
                  ],
                ),
              )
            );
          }
        );
      }
    );
  }
  Widget howMany(List<int>random,int num){
    if(num==1)
      {
        return rollaDice(random[0]);
      }
    else if(num==2)
      {
        return Wrap(
          spacing: 10,
          children: <Widget>[rollaDice(random[0]),rollaDice(random[1])]
        );
      }
    else if(num==3)
      {
        return Wrap(
          spacing: 10,
          children: <Widget>[rollaDice(random[0]),rollaDice(random[1]),rollaDice(random[2])]
        );
      }
    else if(num==4)
      {
        return Wrap(
          spacing: 10,
          children: <Widget>[rollaDice(random[0]),rollaDice(random[1]),rollaDice(random[2]),rollaDice(random[3])]
        );
      }
    else if(num==5)
      {
        return Wrap(
          spacing: 10,
          children: <Widget>[rollaDice(random[0]),rollaDice(random[1]),rollaDice(random[2]),rollaDice(random[3]),rollaDice(random[4])]
        );
      }
    else
      {
        return Wrap(
          spacing: 10,
          children: <Widget>[rollaDice(random[0]),rollaDice(random[1]),rollaDice(random[2]),rollaDice(random[3]),rollaDice(random[4]),rollaDice(random[5])]
        );
      }
  }

  Widget rollaDice(int random){
    switch (random) {
      case 1:return Icon(FlutterIcons.dice_one_faw5s,color: Colors.redAccent,size: 120,);
        break;
      case 2:return Icon(FlutterIcons.dice_two_faw5s,color: Colors.redAccent,size:120);
        break;
      case 3:return Icon(FlutterIcons.dice_three_faw5s,color: Colors.redAccent,size:120);
        break;
      case 4:return Icon(FlutterIcons.dice_four_faw5s,color: Colors.redAccent,size:120);
        break;
      case 5:return Icon(FlutterIcons.dice_five_faw5s,color: Colors.redAccent,size:120);
        break;
      case 6:return Icon(FlutterIcons.dice_six_faw5s,color: Colors.redAccent,size:120);
        break;      
      default:return Container();
    }
  }

  coin(BuildContext context){
    int rand =Random().nextInt(1) + 1;
    String selected="India";
    Random random = new Random();
    const menuitems=<String>["India","USD","Yen","Dhiram","Pounds","Antique"];
    final List<DropdownMenuItem<String>>_dropmenuitems=menuitems.map((String value) => DropdownMenuItem<String>(child:Text(value),value:value.toString(),)).toList();
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(context,setState){
            return AlertDialog(
              scrollable: true,
              actions: <Widget>[
                RaisedButton(
                  onPressed:(){
                    setState(() {
                      rand =Random().nextInt(2) + 1;
                    });                    
                  },
                  child:Text("Flip it",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black)),
                  color: Colors.teal,
                  disabledColor: Colors.teal,
                ),
                SizedBox(width: 20,),                               
                FlatButton(
                  onPressed:(){
                    Navigator.pop(context);},
                  child: Text("Done",style: TextStyle(fontSize:18),)),
              ],
              backgroundColor: AppColors.primaryWhite,
              title:Center(child: Text("Flip A Coin",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              content: Center(
                child: Column(
                  children: <Widget>[
                    Text("What coin you want to flip?",style: TextStyle(fontSize: 18),),
                    DropdownButton(
                      items:_dropmenuitems,
                      value: selected,
                      iconDisabledColor: Colors.teal,
                      iconEnabledColor: Colors.teal,
                      style: TextStyle(color:Colors.teal,fontWeight:FontWeight.w500,fontSize: 18),
                      onChanged:(String value){
                        setState(() {
                          selected=value;
                        });
                      }
                    ),
                    Container(
                      child:Image(
                        width: MediaQuery.of(context).size.width/2,
                        height: MediaQuery.of(context).size.width/2,
                        fit: BoxFit.fill,
                        image:AssetImage('assets/coins/${selected.toLowerCase()}_$rand.jpeg')) ),
                    SizedBox(height:10),
                    Text("Its a ${rand==2?"tails":"Heads"}",style: TextStyle(color:Color.fromARGB(255, random.nextInt(150), random.nextInt(255), random.nextInt(255)),fontWeight: FontWeight.w500,fontSize: 20),)
                  ],
                ),
              )
            );
          }
        );
      }
    );
  }


 card(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(context,setState){
            return AlertDialog(
              scrollable: true,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: RaisedButton(
                    onPressed:(){
                      setState(() {
                        globals.remaining=52;
                        fetchDeck().then((data) {
                        globals.deckId=data.deckId;
                        fetchCard(globals.deckId).then((data1) {
                          globals.image=data1.list[0]['image'];
                          globals.remaining=data1.remaining;
                          });
                        });
                      });                    
                    },
                    child:Text("New Deck",style: TextStyle(fontSize:18,fontWeight: FontWeight.bold,color: Colors.black)),
                    color: Colors.redAccent,
                    disabledColor: Colors.redAccent,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: RaisedButton(
                    onPressed:(){
                      fetchCard(globals.deckId).then((data1) {
                        globals.image=data1.list[0]['image'];
                        globals.remaining=data1.remaining;
                      });
                      setState(() {
                      });                   
                    },
                    child:Text("Draw",style: TextStyle(fontSize:18,fontWeight: FontWeight.bold,color: Colors.black)),
                    color: Colors.teal,
                    disabledColor: Colors.teal,
                  ),
                ),                             
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: FlatButton(
                    onPressed:(){
                      Navigator.pop(context);},
                    child: Text("Done",style: TextStyle(fontSize:18),)),
                ),
              ],
              backgroundColor: AppColors.primaryWhite,
              title:Center(child: Text("Random Card",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              content: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      child:Image(
                        width: MediaQuery.of(context).size.width/2,
                        height: MediaQuery.of(context).size.height/3,
                        fit: BoxFit.fill,
                        image:NetworkImage(globals.image==null?'https://res.cloudinary.com/teepublic/image/private/s--FfQ2HfW9--/t_Resized%20Artwork/c_fit,g_north_west,h_954,w_954/co_ffffff,e_outline:48/co_ffffff,e_outline:inner_fill:48/co_ffffff,e_outline:48/co_ffffff,e_outline:inner_fill:48/co_bbbbbb,e_outline:3:1000/c_mpad,g_center,h_1260,w_1260/b_rgb:eeeeee/c_limit,f_jpg,h_630,q_90,w_630/v1533062864/production/designs/2961761_0.jpg':globals.image))),
                    SizedBox(height:20),
                    Text("Remaining Cards: ${globals.remaining}",style: TextStyle(color: Colors.purpleAccent,fontWeight: FontWeight.w500,fontSize: 18),)
                  ],
                ),
              )
            );
          }
        );
      }
    );
  }

  name(BuildContext context){
    const menuitems=<String>["Male","Female"];
    String selected='Male';
    final List<DropdownMenuItem<String>>_dropmenuitems=menuitems.map((String value) => DropdownMenuItem<String>(child:Text(value),value:value.toString(),)).toList();
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(context,setState){
            return AlertDialog(
              scrollable: true,
              actions: <Widget>[
                RaisedButton(
                  onPressed:(){               
                    setState(() {
                    });
                  },
                  child:Text("Try again",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black)),
                  color: Colors.teal,
                  disabledColor: Colors.teal,
                ),
                SizedBox(width: 20,),                               
                FlatButton(
                  onPressed:(){
                    Navigator.pop(context);},
                  child: Text("Done",style: TextStyle(fontSize:18),)),
              ],
              backgroundColor: AppColors.primaryWhite,
              title:Center(child: Text("Random Name",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              content: Center(
                child: Column(
                  children: <Widget>[
                   DropdownButton(
                      items:_dropmenuitems,
                      value: selected,
                      iconDisabledColor: Colors.teal,
                      iconEnabledColor: Colors.teal,
                      style: TextStyle(color:Colors.teal,fontWeight:FontWeight.w500,fontSize: 18),
                      onChanged:(String value){
                       setState(() {
                        selected=value;
                      });
                      }
                    ),
                    Text(mockName('${selected.toLowerCase()}'),style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.w500,fontSize: 30),textAlign: TextAlign.center,),
                  ],
                ),
              )
            );
          }
        );
      }
    );
  }
  movies(BuildContext context){
    const menuitems=<String>["Hollywood","Bollywood"];
    Random random = new Random();
    int rand=(0+ random.nextInt(116));
    String selected="Hollywood"; 
    final List<DropdownMenuItem<String>>_dropmenuitems=menuitems.map((String value) => DropdownMenuItem<String>(child:Text(value),value:value.toString(),)).toList();
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(context,setState){
            return AlertDialog(
              scrollable: true,
              actions: <Widget>[
                RaisedButton(
                  onPressed:(){                  
                    setState((){
                      rand=(0+ random.nextInt(116));
                      print(rand);
                    });
                  },
                  child:Text("Draw",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black)),
                  color: Colors.teal,
                  disabledColor: Colors.teal,
                ),
                SizedBox(width: 20,),                               
                FlatButton(
                  onPressed:(){
                    Navigator.pop(context);},
                  child: Text("Done",style: TextStyle(fontSize:18),)),
              ],
              backgroundColor: AppColors.primaryWhite,
              title:Center(child: Text("Random Movie",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              content: Center(
                child: Column(
                  children: <Widget>[
                    DropdownButton(
                      items:_dropmenuitems,
                      value: selected,
                      iconDisabledColor: Colors.teal,
                      iconEnabledColor: Colors.teal,
                      style: TextStyle(color:Colors.teal,fontWeight:FontWeight.w500,fontSize: 18),
                      onChanged:(String value){
                       setState(() {
                        selected=value;
                        value=="Hollywood"?fetchMovie(true):fetchMovie(false);
                      });
                      }
                    ),
                    Container(
                      child:Image(
                        width: MediaQuery.of(context).size.width/2,
                        height: MediaQuery.of(context).size.height/3,
                        fit: BoxFit.fill,
                        image:NetworkImage(globals.movieList[rand].url))),                    
                    SizedBox(height:10),
                    Text("Title:${globals.movieList[rand].title}",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.w500,fontSize: 18),textAlign: TextAlign.center,),
                    Text("Year:${globals.movieList[rand].year}",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.w500,fontSize: 18),),
                    Text("IMDb rating:${globals.movieList[rand].rating}",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.w500,fontSize: 18),)
                  ],
                ),
              )
            );
          }
        );
      }
    );
  }

  facts(BuildContext context){
    String fact=globals.fact;
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(context,setState){
            return AlertDialog(
              scrollable: true,
              actions: <Widget>[
                RaisedButton(
                  onPressed:(){
                    fetchFact().then((value) {
                      globals.fact=value.fact;
                    });                 
                    setState((){
                      fact=globals.fact;
                    });
                  },
                  child:Text("Draw",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black)),
                  color: Colors.teal,
                  disabledColor: Colors.teal,
                ),
                SizedBox(width: 20,),                               
                FlatButton(
                  onPressed:(){
                    Navigator.pop(context);},
                  child: Text("Done",style: TextStyle(fontSize:18),)),
              ],
              backgroundColor: AppColors.primaryWhite,
              title:Center(child: Text("Random Fact",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              content: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      child:Center(child: Text(fact==null?"":fact,style: TextStyle(fontSize:20,fontWeight: FontWeight.w500,color:Colors.purpleAccent),textAlign: TextAlign.center,))
                    ),                    
                  ],
                ),
              )
            );
          }
        );
      }
    );
  }

 yesNo(BuildContext context){
    int rand;
    String result;
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(context,setState){
            return AlertDialog(
              scrollable: true,
              actions: <Widget>[
                RaisedButton(
                  onPressed:(){              
                    setState((){
                      rand=Random().nextInt(6)+1;
                      switch (rand) {
                        case 1:result="Yes";
                          break;
                        case 2:result="No";
                          break;
                        case 3:result="Definitely not";
                          break;
                        case 4:result="Yeah go for it";
                          break;
                        case 5:result="Hell no";
                          break;                
                        case 6:result="Yes,it is the best chance";
                          break;        
                        default:
                      }
                    });
                  },
                  child:Text("Tap here",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black)),
                  color: Colors.teal,
                  disabledColor: Colors.teal,
                ),
                SizedBox(width: 20,),                               
                FlatButton(
                  onPressed:(){
                    Navigator.pop(context);},
                  child: Text("Done",style: TextStyle(fontSize:18),)),
              ],
              backgroundColor: AppColors.primaryWhite,
              title:Center(child: Text("Yes or No",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              content: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      child:Center(child: Text(rand==null?"Ask the app a question and tap on the button below to get the answer":result,style: TextStyle(fontSize:20,fontWeight: FontWeight.w500,color:Colors.pinkAccent),textAlign: TextAlign.center,))
                    ),                    
                  ],
                ),
              )
            );
          }
        );
      }
    );
  }
  countries(BuildContext context){
    Random random = new Random();
    int rand=(0+ random.nextInt(190)); 
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(context,setState){
            return AlertDialog(
              scrollable: true,
              actions: <Widget>[
                RaisedButton(
                  onPressed:(){                  
                    setState((){
                      rand=(0+ random.nextInt(190));
                      print(rand);
                    });
                  },
                  child:Text("Draw",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black)),
                  color: Colors.teal,
                  disabledColor: Colors.teal,
                ),
                SizedBox(width: 20,),                               
                FlatButton(
                  onPressed:(){
                    Navigator.pop(context);},
                  child: Text("Done",style: TextStyle(fontSize:18),)),
              ],
              backgroundColor: AppColors.primaryWhite,
              title:Center(child: Text("Random Country",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              content: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      child:SvgPicture.network(
                              '${globals.countryList[rand].url}',
                              semanticsLabel: 'Flag',
                              width: MediaQuery.of(context).size.width/2,
                              height: MediaQuery.of(context).size.width/2,
                              placeholderBuilder: (BuildContext context) => Container(
                                padding: const EdgeInsets.all(30.0),
                                child: const CircularProgressIndicator()),
                            )
                    ),
                    SizedBox(height:10),
                    Text("Country:${globals.countryList[rand].name}",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w500,fontSize: 18),textAlign: TextAlign.center,),
                    Text("Captial:${globals.countryList[rand].capital}",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w500,fontSize: 18),),
                    Text("Continent:${globals.countryList[rand].continent}",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w500,fontSize: 18),),
                  ],
                ),
              )
            );
          }
        );
      }
    );
  }

  games(BuildContext context){
    Random random = new Random();
    int rand=(0+ random.nextInt(220));
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(context,setState){
            return AlertDialog(
              scrollable: true,
              actions: <Widget>[
                RaisedButton(
                  onPressed:(){                  
                    setState((){
                      rand=(0+ random.nextInt(220));
                    });
                  },
                  child:Text("Draw",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black)),
                  color: Colors.teal,
                  disabledColor: Colors.teal,
                ),
                SizedBox(width: 20,),                               
                FlatButton(
                  onPressed:(){
                    Navigator.pop(context);},
                  child: Text("Done",style: TextStyle(fontSize:18),)),
              ],
              backgroundColor: AppColors.primaryWhite,
              title:Center(child: Text("Random Game",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              content: Center(
                child: Column(
                  children: <Widget>[
                    Text("Title:${globals.gameList[rand].name}",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w500,fontSize: 18),textAlign: TextAlign.center,),
                    SizedBox(height:14),
                    Text("Release year:${globals.gameList[rand].year}",style: TextStyle(color: Colors.purple,fontWeight: FontWeight.w500,fontSize: 18),),
                    Text("Genre:${globals.gameList[rand].genre}",style: TextStyle(color: Colors.purple,fontWeight: FontWeight.w500,fontSize: 18),),
                    Text("IGN rating:${globals.gameList[rand].rating}",style: TextStyle(color: Colors.purple,fontWeight: FontWeight.w500,fontSize: 18),),
                    Text("Platform:${globals.gameList[rand].platform}",style: TextStyle(color: Colors.purple,fontWeight: FontWeight.w500,fontSize: 18),),
                  ],
                ),
              )
            );
          }
        );
      }
    );
  }

 generatePassword(bool _isWithLetters, bool _isWithUppercase,
    bool _isWithNumbers, bool _isWithSpecial, double _numberCharPassword) {

  //Define the allowed chars to use in the password
  String _lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
  String _upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  String _numbers = "0123456789";
  String _special = "@#=+!£\$%&?[](){}";

  //Create the empty string that will contain the allowed chars
  String _allowedChars = "";

  //Put chars on the allowed ones based on the input values
  _allowedChars += (_isWithLetters ? _lowerCaseLetters : '');
  _allowedChars += (_isWithUppercase ? _upperCaseLetters : '');
  _allowedChars += (_isWithNumbers ? _numbers : '');
  _allowedChars += (_isWithSpecial ? _special : '');

  int i = 0;
  String _result = "";

  //Create password
  while (i < _numberCharPassword.round()) {
    //Get random int
    int randomInt = Random.secure().nextInt(_allowedChars.length);
    //Get random char and append it to the password
    _result += _allowedChars[randomInt];
    i++;
  }

  globals.pass=_result;
}

  randomPass(BuildContext context){
    bool letters=true,upperCase=false,numbers=false,special=false;
    double digit;
    TextEditingController controller=TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(context,setState){
            return AlertDialog(
              scrollable: true,
              actions: <Widget>[
                RaisedButton(
                  onPressed:(){                  
                    setState((){
                      generatePassword(letters, upperCase, numbers, special, digit);
                    });
                  },
                  child:Text("Draw",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,)),
                  color: Colors.teal,
                  disabledColor: Colors.teal,
                ),
                SizedBox(width: 20,),                               
                FlatButton(
                  onPressed:(){
                    Navigator.pop(context);},
                  child: Text("Done",style: TextStyle(fontSize:18),)),
              ],
              backgroundColor: AppColors.primaryWhite,
              title:Center(child: Text("Random Password",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              content: Center(
                child: Column(
                  children: <Widget>[
                    TextField(
                      textAlign: TextAlign.center,
                      maxLength: 2,
                      
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'How many chracters allowed?',
                        labelStyle: TextStyle(color:Colors.teal,fontWeight:FontWeight.w500),
                      ),
                      controller: controller,
                      keyboardType: TextInputType.number, 
                      onChanged:(result){
                        setState((){
                          digit=double.parse(result);
                        }) ;
                       },                         
                    ),
                    CheckboxListTile(
                      value: letters,
                      title: Text("Allow letters?",style: TextStyle(color:Colors.teal,fontWeight:FontWeight.w500),),
                      onChanged:(result){
                        setState((){
                          letters=result;
                        });
                      }),
                    CheckboxListTile(
                      value: upperCase,
                      title: Text("Allow uppercase?",style: TextStyle(color:Colors.teal,fontWeight:FontWeight.w500),),
                      onChanged:(result){
                        setState((){
                          upperCase=result;
                        });
                      }),
                    CheckboxListTile(
                      value: numbers,
                      title: Text("Allow numbers?",style: TextStyle(color:Colors.teal,fontWeight:FontWeight.w500),),
                      onChanged:(result){
                        setState((){
                          numbers=result;
                        });
                      }),
                    CheckboxListTile(
                      value: special,
                      title: Text("Allow special chracters?",style: TextStyle(color:Colors.teal,fontWeight:FontWeight.w500),),
                      onChanged:(result){
                        setState((){
                          special=result;
                        });
                      }),
                    SizedBox(height:14),
                    SelectableText(
                      globals.pass==null?"":globals.pass,
                        style:TextStyle(
                          color:Colors.red,
                          fontWeight:FontWeight.w500,
                          fontSize:25),
                          toolbarOptions: ToolbarOptions(copy:true,selectAll:true),
                        ),
                  ],
                ),
              )
            );
          }
        );
      }
    );
  }

 date(BuildContext context){
    var from=DateTime.utc(1989, 11, 9);
    var to=DateTime.now();
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(context,setState){
            return AlertDialog(
              scrollable: true,
              actions: <Widget>[
                RaisedButton(
                  onPressed:(){               
                    setState((){
                    });
                  },
                  child:Text("Randomize",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black)),
                  color: Colors.teal,
                  disabledColor: Colors.teal,
                ),
                SizedBox(width: 20,),                               
                FlatButton(
                  onPressed:(){
                    Navigator.pop(context);},
                  child: Text("Done",style: TextStyle(fontSize:18),)),
              ],
              backgroundColor: AppColors.primaryWhite,
              title:Center(child: Text("Random Date",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              content: Center(
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        RaisedButton(
                          child: Text("From",style:TextStyle(fontWeight:FontWeight.w500),),
                          color: Colors.teal,
                          onPressed:()async{
                            from= await showDatePicker(fieldLabelText: "Select first date",helpText:"Select from date",context: context, initialDate: DateTime.now(), firstDate:DateTime.parse("1980-05-10"), lastDate:DateTime.now(),);
                            setState((){
                            });
                          } 
                        ),
                        Text(from==null?"":"From:${from.day.toString()}-${from.month.toString().padLeft(2,'0')}-${from.year.toString().padLeft(2,'0')}",style:TextStyle(fontWeight:FontWeight.w500),),
                        SizedBox(height:10),
                        RaisedButton(
                          child: Text("To",style:TextStyle(fontWeight:FontWeight.w500),),
                          color: Colors.teal,
                          onPressed:()async{
                            to= await showDatePicker(fieldLabelText: "Select second date",helpText:"Select to date",context: context, initialDate: from, firstDate:from, lastDate:DateTime.utc(2030,12,31));
                            setState((){
                            });
                          } 
                        ),
                        Text(to==null?"":"To:${to.day.toString()}-${to.month.toString().padLeft(2,'0')}-${to.year.toString().padLeft(2,'0')}",style:TextStyle(fontWeight:FontWeight.w500),),
                        SizedBox(height:20),
                        Center(child:Text(from==null?"":"Result:${mockDate(from,to).day.toString()}-${mockDate(from,to).month.toString().padLeft(2,'0')}-${mockDate(from,to).year.toString().padLeft(2,'0')}",style: TextStyle(fontSize:22,fontWeight: FontWeight.w500,color:Colors.deepOrange),textAlign: TextAlign.center,)),
                      ],
                    ),                    
                  ],
                ),
              )
            );
          }
        );
      }
    );
  }
 place(BuildContext context){
   Completer<GoogleMapController> _controller = Completer();
   final random = Random();
      final Set<Marker> _markers = {};
  double randomLat = -90 + random.nextDouble() * 90 * 2;
  double randomLng = -180 + random.nextDouble() * 180 * 2;
   final CameraPosition initial = CameraPosition(
    target: LatLng(randomLat, randomLng),
    zoom: 3,
  );
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(context,setState){
            return AlertDialog(
              scrollable: true,
              actions: <Widget>[
                RaisedButton(
                  onPressed:()async{
                    randomLat = -90 + random.nextDouble() * 90 * 2;
                    randomLng = -180 + random.nextDouble() * 180 * 2;    
                    final GoogleMapController controller = await _controller.future;
                    controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          tilt:10,
                          target: LatLng(randomLat, randomLng),
                          zoom: 3,
                        )));          
                    setState((){
                      _markers.add(Marker(
                        markerId: MarkerId(("1").toString()),
                        position:LatLng(randomLat, randomLng) ,
                        icon: BitmapDescriptor.defaultMarker,
                      ));
                    });
                  },
                  child:Text("Randomize",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black)),
                  color: Colors.teal,
                  disabledColor: Colors.teal,
                ),
                SizedBox(width: 20,),                               
                FlatButton(
                  onPressed:(){
                    Navigator.pop(context);},
                  child: Text("Done",style: TextStyle(fontSize:18),)),
              ],
              backgroundColor: AppColors.primaryWhite,
              title:Center(child: Text("Random Location",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              content: Center(
                child:Container(
                  width: MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.width/1.5 ,
                  padding: EdgeInsets.all(15),
                  child:GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: initial,
                    markers: _markers,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ), 
                )
              )
            );
          }
        );
      }
    );
  }

 letters(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(context,setState){
            return AlertDialog(
              scrollable: true,
              actions: <Widget>[
                RaisedButton(
                  onPressed:(){                
                    setState((){
                    });
                  },
                  child:Text("Randomize",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black)),
                  color: Colors.teal,
                  disabledColor: Colors.teal,
                ),
                SizedBox(width: 20,),                               
                FlatButton(
                  onPressed:(){
                    Navigator.pop(context);},
                  child: Text("Done",style: TextStyle(fontSize:18),)),
              ],
              backgroundColor: AppColors.primaryWhite,
              title:Center(child: Text("Random Letter",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              content: Center(
                child: Container(
                  child:Center(child: Text(mockString(1,'aA').toUpperCase(),style: TextStyle(fontSize:25,fontWeight: FontWeight.w500,color:Colors.pinkAccent),textAlign: TextAlign.center,))
                ),
              )
            );
          }
        );
      }
    );
  }

color(BuildContext context){
  String result=generateRandomHexColor();
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(context,setState){
            return AlertDialog(
              scrollable: true,
              actions: <Widget>[
                RaisedButton(
                  onPressed:(){              
                    setState((){
                      result=generateRandomHexColor();
                      }
                    );
                  },
                  child:Text("Randomize",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black)),
                  color: Colors.teal,
                  disabledColor: Colors.teal,
                ),
                SizedBox(width: 20,),                               
                FlatButton(
                  onPressed:(){
                    Navigator.pop(context);},
                  child: Text("Done",style: TextStyle(fontSize:18),)),
              ],
              backgroundColor: AppColors.primaryWhite,
              title:Center(child: Text("Random Color",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              content: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width/1.3,
                  height:MediaQuery.of(context).size.width/1.3,
                  color: Color(int.parse(result.replaceAll('#','0xFF' ))),
                  child: Center(child: SelectableText(result,
                    toolbarOptions: ToolbarOptions(copy:true,selectAll:true),
                    style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.w500),)),
                ),
              )
            );
          }
        );
      }
    );
  } 

  String generateRandomHexColor(){
    Random random = new Random();
    int length = 6;
    String chars = '0123456789ABCDEF';
    String hex = '#';
    while(length-- > 0) hex += chars[(random.nextInt(16)) | 0];
    return hex;
} 

  elements(BuildContext context){
    Random random = new Random();
    int rand=(0+ random.nextInt(119));
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(context,setState){
            return AlertDialog(
              scrollable: true,
              actions: <Widget>[
                RaisedButton(
                  onPressed:(){                  
                    setState((){
                      rand=(0+ random.nextInt(119));
                    });
                  },
                  child:Text("Randomize",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.white)),
                  color: Colors.teal,
                  disabledColor: Colors.teal,
                ),
                SizedBox(width: 20,),                               
                FlatButton(
                  onPressed:(){
                    Navigator.pop(context);},
                  child: Text("Done",style: TextStyle(fontSize:18),)),
              ],
              backgroundColor: AppColors.primaryWhite,
              title:Center(child: Text("Random Element",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              content: Center(
                child: Column(
                  children: <Widget>[
                    Text("Name:${globals.elementList[rand].name}(${globals.elementList[rand].symbol})",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w500,fontSize: 22),textAlign: TextAlign.center,),
                    Text("Atomic No:${globals.elementList[rand].number}",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.w500,fontSize: 18),),
                    Text("Atomic mass:${globals.elementList[rand].mass}",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.w500,fontSize: 18),),
                    Text("Electronic configuration:${globals.elementList[rand].config}",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.w500,fontSize: 18),textAlign: TextAlign.center,),
                    SizedBox(height:10),
                    OutlineButton(
                      onPressed: ()=>launch(globals.elementList[rand].source),
                      child: Text("Wikipedia",style: TextStyle(fontSize: 18),),
                      borderSide: BorderSide(color: Colors.teal,width: 3.0),
                    )
                  ],
                ),
              )
            );
          }
        );
      }
    );
  }

 wikipedia(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(context,setState){
            return AlertDialog(
              scrollable: true,
              actions: <Widget>[
                SizedBox(width: 20,),                               
                FlatButton(
                  onPressed:(){
                    Navigator.pop(context);},
                  child: Text("Done",style: TextStyle(fontSize:18),)),
              ],
              backgroundColor: AppColors.primaryWhite,
              title:Center(child: Text("Random Wikipedia",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              content: Center(
                child: Container(
                  child:RaisedButton(
                    onPressed:(){launch('https://en.wikipedia.org/wiki/Special:Random');},
                    child:Text("Randomize wikipedia",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.white)),
                    color: Colors.teal,
                    disabledColor: Colors.teal,
                  ),
                ),
              )
            );
          }
        );
      }
    );
  }

  dogs(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(context,setState){
            return AlertDialog(
              scrollable: true,
              actions: <Widget>[
                RaisedButton(
                  onPressed:(){                  
                    setState((){
                      fetchDog();
                    });
                  },
                  child:Text("Randomize",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black)),
                  color: Colors.teal,
                  disabledColor: Colors.teal,
                ),
                SizedBox(width: 20,),                               
                FlatButton(
                  onPressed:(){
                    Navigator.pop(context);},
                  child: Text("Done",style: TextStyle(fontSize:18),)),
              ],
              backgroundColor: AppColors.primaryWhite,
              title:Center(child: Text("Random Dog breed",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              content: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      child:Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Center(child: CircularProgressIndicator()),
                          Image.network(
                            '${globals.dogimg[0].source}',
                            width: MediaQuery.of(context).size.width/2,
                            height: MediaQuery.of(context).size.width/2,
                          ),
                        ],
                      )
                    ),
                    SizedBox(height:10),
                    Text("Name:${globals.dogList[0].name}",style: TextStyle(color: Colors.indigo[900],fontWeight: FontWeight.w500,fontSize: 18),textAlign: TextAlign.center,),
                    Text("Life span:${globals.dogList[0].life_span}",style: TextStyle(color: Colors.indigo[900],fontWeight: FontWeight.w500,fontSize: 18),),
                    Text("Temprament:${globals.dogList[0].temperament}",style: TextStyle(color: Colors.indigo[900],fontWeight: FontWeight.w500,fontSize: 18),textAlign: TextAlign.center,),
                  ],
                ),
              )
            );
          }
        );
      }
    );
  }

  food(BuildContext context){
    String img=globals.foodList[0].image;
    String url=globals.foodList[0].url;
    String name=globals.foodList[0].name;
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(context,setState){
            return AlertDialog(
              scrollable: true,
              actions: <Widget>[
                RaisedButton(
                  onPressed:(){  
                    fetchFood();                
                    setState((){
                      img=globals.foodList[0].image;
                      url=globals.foodList[0].url;
                      name=globals.foodList[0].name;
                    });
                  },
                  child:Text("Randomize",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black)),
                  color: Colors.teal,
                  disabledColor: Colors.teal,
                ),
                SizedBox(width: 20,),                               
                FlatButton(
                  onPressed:(){
                    Navigator.pop(context);},
                  child: Text("Done",style: TextStyle(fontSize:18),)),
              ],
              backgroundColor: AppColors.primaryWhite,
              title:Center(child: Text("Random Dish",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              content: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      child:Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Center(child: CircularProgressIndicator()),
                          Image.network(
                            img,
                            width: MediaQuery.of(context).size.width/2,
                            height: MediaQuery.of(context).size.width/2,
                          ),
                        ],
                      )
                    ),
                    SizedBox(height:20),
                    Text("Dish:$name",style: TextStyle(color: Colors.indigo[900],fontWeight: FontWeight.w500,fontSize: 20),textAlign: TextAlign.center,),
                    SizedBox(height:10),
                    OutlineButton(
                      child:Text("Recipe",style: TextStyle(color:Colors.black,fontSize: 22,fontWeight: FontWeight.bold),),
                      borderSide: BorderSide(width:3,color:Colors.teal),
                      onPressed:(){launch(url);})
                  ],
                ),
              )
            );
          }
        );
      }
    );
  }