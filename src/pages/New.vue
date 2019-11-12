<template lang="pug">
  q-page
    div.f NEW
      q-input(v-model="collab.name" filled) name
      q-input(v-model="collab.birth" type="date" filled) birthday
      q-input(v-model="collab.salary" filled) salary
      q-checkbox(v-model="collab.status") status
      p SECTORS:
      div(
        v-for="[index, sector] in collab.sectors.entries()"
        :key="index"
      ).flex
        q-input(
          v-model="sector.name"
          filled
        ) sector name
        q-btn(@click="collab.sectors.splice(index, 1)") delete
      q-btn(@click="addSector" color="positive") Add sector
      div.actions.flex
        q-btn(@click="$router.push('/')" flat) Go back
        q-btn(@click="send" color="positive") Save
</template>

<style lang="stylus" scoped>
.f
  width 400px
  margin 20px auto
  .q-input
    margin-bottom 10px
.actions
  justify-content space-between
</style>

<script>
const axios = require('axios');

export default {
  name: 'NewPage',
  data() {
    return {
      collab: {
        name: '',
        birth: '',
        salary: 0,
        status: false,
        sectors: [],
      },
    };
  },
  methods: {
    send() {
      const url = 'http://api.vitorfhc.com/collaborators';
      axios.post(url, this.collab)
        .then((res) => {
          if (res.status === 200) {
            this.$router.push('/');
          }
        });
    },
    addSector() {
      this.collab.sectors.push({ name: '' });
    },
  },
};
</script>
