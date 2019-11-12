<template lang="pug">
  q-page
    div.f EDIT
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
      q-btn(@click="collab.sectors.push({ name: '' })" color="positive") Add sector
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
  name: 'EditPage',
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
      const dateToSend = new Date(this.collab.birth);
      this.collab.birth = dateToSend;
      const url = `http://api.vitorfhc.com/collaborators/${this.$route.params.id}`;
      axios.post(url, this.collab)
        .then((res) => {
          if (res.status === 200) {
            this.$router.go();
          }
        });
    },
  },
  mounted() {
    axios.get(`http://api.vitorfhc.com/collaborators/${this.$route.params.id}`)
      .then((res) => {
        [this.collab] = res.data;
        const birth = new Date(this.collab.birth);
        let month = `0${birth.getMonth() + 1}`;
        month = month.slice(-2);
        let day = `0${birth.getDate()}`;
        day = day.slice(-2);
        const birthString = `${birth.getFullYear()}-${month}-${day}`;
        this.collab.birth = birthString;
      });
  },
};
</script>
