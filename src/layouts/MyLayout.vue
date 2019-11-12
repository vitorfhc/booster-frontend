<template lang="pug">
  q-layout
    q-page
      router-view
</template>

<script>
import { openURL } from 'quasar';

export default {
  name: 'MyLayout',
  data() {
    return {
      leftDrawerOpen: false,
    };
  },
  methods: {
    openURL,
  },
};
</script>

<style lang="stylus">
</style>
