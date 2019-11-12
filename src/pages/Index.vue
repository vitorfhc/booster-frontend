<template lang="pug">
  q-page
    div.collabs
      span.title.flex.column List of all collaborators
      table.tab
        tr
          th name
          th birth
          th salary
          th status
          th created at
          th updated at
          th sectors
        tr(v-for="collab in collabs")
          td {{ collab.name }}
          td {{ collab.birth }}
          td {{ collab.salary }}
          td {{ collab.status }}
          td {{ collab.metadata.created_at }}
          td {{ collab.metadata.updated_at }}
          td
            span(v-for="sector in collab.sectors")
              | {{ sector.name + ', '}}
          td.action
            q-btn(@click="edit(collab._id)" flat) edit
          td.action
            q-btn(color="negative" @click="remove(collab._id)" flat) remove
      q-btn(color="positive" @click="$router.push('/new')").new new collaborator
</template>

<style lang="stylus" scoped>
th, td
  border 1px solid black
  text-align center
  padding 10px
tr
  min-width 50%
.action
  width 6%
.new
  margin 10px
.title
  margin 10px
  font-size 30px
  align-content center
</style>

<script>
const axios = require('axios');

export default {
  name: 'InitialPage',
  data() {
    return {
      collabs: undefined,
    };
  },
  methods: {
    remove(id) {
      axios.delete(`http://api.vitorfhc.com/collaborators/${id}`)
        .then(() => {
          this.$router.go();
        });
    },
    edit(id) {
      this.$router.push({
        name: 'edit',
        params: { id },
      });
    },
  },
  mounted() {
    axios.get('http://api.vitorfhc.com/collaborators')
      .then((response) => {
        this.collabs = response.data;
        this.collabs.forEach((element) => {
          const birth = new Date(element.birth);
          element.birth = birth.toDateString();
        });
      });
  },
};
</script>
