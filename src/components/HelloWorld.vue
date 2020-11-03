<template>
  <v-container>
    <v-row class="text-center">
      <v-col cols="12">
          <v-row>
            <v-col align="center"  cols="4">
              <v-row>
                <v-col  cols="12">

                  <v-img v-if="finalMessage != null " :src="require(`../assets/DiceImages/${finalMessage['0']}.jpg`)" class="my-3" contain  height="200" />
                  <v-img v-if="finalMessage == null " :src="require('../assets/DiceImages/0.png')" class="my-3" contain  height="200" />
                </v-col>
              </v-row>
              <v-row>
               
              </v-row>
            </v-col>
            <v-col cols="4" >
              <v-img v-if="GameStatus == 'Processing' " :src="require(`../assets/DiceImages/scared.png`)" class="my-3" contain  height="200" />
              <div   v-if="finalMessage != null ">
                
                <v-img v-if="finalMessage['2'] == 'Sorry !! Better luck in Next time' " :src="require(`../assets/DiceImages/sad.png`)" class="my-3" contain  height="200" />
                <v-img v-if="finalMessage['2'] == 'Congratulations !! You win' " :src="require(`../assets/DiceImages/smile.png`)" class="my-3" contain  height="200" />
                <!-- <v-img v-if="finalMessage != null " :src="require(`../assets/DiceImages/${finalMessage['0']}.jpg`)" class="my-3" contain  height="200" /> -->

              </div>
            </v-col>
            <v-col cols="4">
              <v-row>
                <v-col cols="12">
                  <v-img v-if="choosedDiceSide != null" :src="require(`../assets/DiceImages/${choosedDiceSide}.jpg`)" class="my-3" contain  height="200" />
                  <v-img v-if="choosedDiceSide == null" :src="require(`../assets/DiceImages/waiting.png`)" class="my-3" contain  height="200" />
                </v-col>
              </v-row>
              <v-row>
                <v-col align="center"  cols="12">  
                </v-col>
              </v-row>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12">
              <v-btn dark v-if="  GameStatus == 'Finished'  " @click="tryAgain" depressed color="primary" >Try Again </v-btn>
            </v-col>
          </v-row>
          <v-row v-if=" GameStatus == 'WaitingChooseDiceSide'  " >
            <v-col cols="12">
              <v-row>
                <v-col cols="12">
                  <h2> Select one from here </h2>
                </v-col>
              </v-row>
                <v-row>
                  <v-col cols="12">
                    <v-container  >
                      <v-row align="center"   >
                        <v-col  v-for="n in 6" :key="n" >
                          <v-card  @click="choosedDiceSide = n" outlined tile >
                            <v-img :src="require(`../assets/DiceImages/${n}.jpg`)"  contain height="100" />
                          </v-card>
                        </v-col>
                      </v-row>
                    </v-container>
                  </v-col>
                </v-row>
            </v-col>
          </v-row>
          <v-row  v-if=" GameStatus == 'WaitingChooseDiceSide' &&  choosedDiceSide != null " >
              <v-col cols="8">
                  <v-text-field  v-model="bet"   type="number" label="Enter Etherium mount"  required ></v-text-field>
              </v-col>
              <v-col cols="4" >
                <v-btn dark v-if="bet > .1" @click="PlayGame" depressed color="primary" >Play Game</v-btn>
              </v-col>
          </v-row> 
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import web3 from '@/web3' 
import game from '@/game'
  export default {
    name: 'HelloWorld',
    data: () => ({
      bet : 0,
      finalMessage : null,
      choosedDiceSide : null,
      GameStatus : "WaitingChooseDiceSide" 
    }),
    methods:{
      async PlayGame(){ 
        this.GameStatus = "Processing"  
         const res = await game.methods.enterToGame(this.choosedDiceSide).send({
          from : (await web3.eth.getAccounts())[0],
          value : web3.utils.toWei( this.bet.toString() , 'ether')
        })
        this.finalMessage = res.events.finalMessage.returnValues;
        console.log(res.events.finalMessage.returnValues);
        this.bet =0 
        this.GameStatus = "Finished"
      },
      tryAgain(){
        this.GameStatus = "WaitingChooseDiceSide" ,
        this.finalMessage = null,
        this.choosedDiceSide = null
      }

    },

    computed:{
      // imageChanger(){
      //   if(this.GameStatus == "WaitingForFinalMessage"){
      //     // var i =0 
      //    return (setInterval(() => { 
      //         console.log ("HHH");
      //     }, 3000)) 
      //   }else if(this.GameStatus == "WaitingForSubmit"){
      //     return 0;
      //   }else return null
      // }
    }
  }
</script>
