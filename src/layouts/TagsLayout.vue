<template>
  <q-layout view="lHh Lpr lff" class="shadow-2 rounded-borders">
    <q-header
      class="shadow-8"
      elevated
      :class="$q.dark.isActive ? 'bg-black' : 'bg-primary text-white'"
    >
      <q-toolbar>
        <q-btn flat @click="drawer = !drawer" round dense icon="menu" />

        <q-toolbar-title class="absolute-center text-weight-bold">{{
          noteTitle
        }}</q-toolbar-title>
        <q-btn
          flat
          class="absolute-right q-ma-sm"
          @click="console.log('buscar...')"
          round
          dense
          icon="search"
        />
      </q-toolbar>
    </q-header>

    <q-drawer
      v-model="drawer"
      show-if-above
      :width="230"
      :breakpoint="500"
      bordered
      :class="$q.dark.isActive ? 'bg-grey-9' : 'bg-grey-3'"
    >
      <side-menu @update="updateNote" />
    </q-drawer>

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script setup>
import { ref } from "vue";
import SideMenu from "../components/SideMenu.vue";

const drawer = ref(false);
const noteTitle = ref("");

const updateNote = (note) => {
  noteTitle.value = note.name;
  console.log("actualizar nota:");
  console.log(note);
};
</script>
