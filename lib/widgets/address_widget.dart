import 'package:flutter/material.dart';
class SingleAddress extends StatelessWidget {
  const SingleAddress({super.key, required this.selectedAddress});
final bool selectedAddress;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: selectedAddress ? Color(0xFF282828) : Colors.black54,
      ),
      width: double.infinity,

      margin: EdgeInsets.only(bottom: 15),
      child: Stack(
        children: [
          Positioned(
              right: 5,
              top: 5,
              child: Icon(
                  selectedAddress?
                  Icons.check_circle : null,color:Color(0xFFefcf18),)),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(child: Text("Nishanth MG",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
              SizedBox(height: 10,),
Text("9345738390",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("JCT College of Engineering and Technology - Coimbatore",overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),
              ),

            ],
          )
        ],
      ),
    );
  }
}
