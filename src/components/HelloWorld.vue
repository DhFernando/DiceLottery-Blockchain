<template>
  <v-container>
    <v-row class="text-center">
      <v-col cols="12">
          <v-row>
              <v-col cols="8">
                  <v-text-field  v-model="bet"   type="number" label="Enter Etherium mount"  required ></v-text-field>
              </v-col>
              <v-col cols="4" >
                <v-btn v-if="bet > .1" @click="PlayGame" depressed color="primary" >Play Game</v-btn>
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
      bet : 0
    }),
    methods:{
      async PlayGame(){  
         const res = await game.methods.enterToGame(3).send({
          from : (await web3.eth.getAccounts())[0],
          value : web3.utils.toWei( this.bet.toString() , 'ether')
        })

        console.log(res.events.finalMessage.returnValues[0]);
      }
    }
  }
</script>
