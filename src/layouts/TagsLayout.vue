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

    <q-dialog
      v-model="dialog"
      persistent
      :maximized="true"
      transition-show="slide-up"
      transition-hide="slide-down"
    >
      <q-card class="bg-primary text-white">
        <q-bar>
          <q-space />
          <q-btn dense flat icon="close" v-close-popup>
            <q-tooltip class="bg-white text-primary">Close</q-tooltip>
          </q-btn>
        </q-bar>
        <edit-tags></edit-tags>
      </q-card>
    </q-dialog>

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script setup>
import { ref } from "vue";
import SideMenu from "../components/SideMenu.vue";
import EditTags from "../components/EditTags.vue";

const dialog = ref(false);
const drawer = ref(false);
const noteTitle = ref("");

const updateNote = (note) => {
  noteTitle.value = note.name;
  console.log("actualizar nota:");
  console.log(note);
};
</script>
