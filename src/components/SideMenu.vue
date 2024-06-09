<template>
  <div>
    <div class="row q-gutter-xs q-ml-sm q-mt-sm">
      <div class="text-h6">Tags</div>
      <q-fab color="black" push icon="sell" direction="right" padding="xs">
        <q-fab-action
          color="primary"
          @click="dialog = true"
          icon="edit"
          padding="xs"
        />
        <q-fab-action
          color="accent"
          @click="console.log('ver eliminados...')"
          icon="delete"
          padding="xs"
        />
        <q-fab-action
          color="accent"
          @click="console.log('ver todas las notas...')"
          icon="note"
          padding="xs"
        />
      </q-fab>
    </div>
    <q-tree
      :nodes="simple"
      node-key="id"
      no-connectors
      dense
      v-model:expanded="expanded"
      selected-color="primary"
      v-model:selected="selected"
      @click="console.log(selected)"
    />
  </div>
</template>

<script setup>
import { ref } from "vue";

const expanded = ref([
  "Satisfied customers (with avatar)",
  "Good food (with icon)",
]);

const selected = ref("Categoria 2");

const simple = ref([
  {
    id: 1,
    label: "Categoria 1",
    children: [
      {
        label: "Markdown",
      },
      {
        label: "parte 2",
      },
    ],
  },
  {
    id: 2,
    label: "Categoria 2",
  },
  {
    id: 3,
    label: "Categoria 3",
    children: [
      {
        label: "parte 1",
      },
      {
        label: "parte 2",
      },
    ],
  },
  {
    id: 5,
    label: "Categoria 4",
  },
  {
    id: 4,
    label: "Categoria 5",
  },
]);

function ordenar() {
  simple.value = simple.value.sort((a, b) => {
    if (a.id < b.id) {
      return -1;
    }
  });
}
</script>
