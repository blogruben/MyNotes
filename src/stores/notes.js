import { defineStore } from "pinia";

export const useCounterStore = defineStore("counter", {
  state: () => ({
    counter: 0,
  }),

  //like computed
  getters: {
    doubleCount(state) {
      return state.counter * 2;
    },
  },

  //like methods
  actions: {
    increment() {
      this.counter++;
    },
  },
});
