pragma solidity ^0.4.17;

contract DiceGame{
    
    address public manager;
    uint public noice;
    uint public _randomNumber;
    
    function DiceGame() public payable{ 
        manager = msg.sender;
    }
    
    event finalMessage(uint,uint,string);
    
    function randomNumber() public view returns(uint){
        // gives 1 to 6 random number
        uint rnd = uint(keccak256(block.difficulty , now , noice++))%7;
        if(rnd == 0){
            return rnd++;
        }else{
            return rnd;
        }
    }
    
    
    function enterToGame(uint _guessNumber) public payable{
         require(msg.value > 0.1 ether);
          _randomNumber = randomNumber();
         if(_randomNumber == _guessNumber){ 
             msg.sender.transfer(msg.value*2);
             emit finalMessage( _randomNumber , _guessNumber , "Congratulations !! You win" );
             
             if(this.balance > 10 ether){
                 manager.transfer(this.balance - 10 ether);
             }
             
         }else{
             emit finalMessage( _randomNumber , _guessNumber , "Sorry !! Better luck in Next time" );
             
             if(this.balance > 10 ether){
                 manager.transfer(this.balance - 10 ether);
             }
             
         }
    }
    
    function getManager() public view returns(address , uint){
        return ( manager , manager.balance );
    }
    
}