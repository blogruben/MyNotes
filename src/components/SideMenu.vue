<template>
  <div class="split">
    <q-splitter
      v-model="insideModel"
      horizontal
      :style="height"
      separator-class="bg-grey-4"
      separator-style="height: 3px"
    >
      <template #before>
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
              @click="console.log(altura())"
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
          selected-color="primary bg-blue-2 rounded-borders"
          v-model:selected="selected"
          @click="console.log(selected)"
        />
      </template>

      <template #after>
        <div class="text-h6 q-ml-md q-mt-sm">{{ selectedTag }}</div>
        <q-list dense separator>
          <q-item clickable v-ripple>
            <q-item-section
              >Lorem ipsum dolor sit amet consectetur adipisicing elit. Error
              veritatis
            </q-item-section>
          </q-item>

          <q-item clickable v-ripple v-for="n in 20" :key="n">
            <q-item-section>
              <q-item-label>Nota numero {{ n }}</q-item-label>
            </q-item-section>
          </q-item>
        </q-list>
      </template>
    </q-splitter>
  </div>

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

      <q-card-section>
        <div class="text-h6">Alert</div>
      </q-card-section>

      <q-card-section class="q-pt-none">
        Lorem ipsum dolor sit amet consectetur adipisicing elit. Rerum
        repellendus sit voluptate voluptas eveniet porro. Rerum blanditiis
        perferendis totam, ea at omnis vel numquam exercitationem aut, natus
        minima, porro labore.
      </q-card-section>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { ref, computed } from "vue";

const insideModel = ref(40);
const height = ref("height: " + window.innerHeight + "px");

window.addEventListener("resize", reportWindowSize);

function reportWindowSize() {
  height.value = "height: " + window.innerHeight + "px";
}

const expanded = ref(["3"]);
const dialog = ref(false);

const selected = ref("2");

function altura() {
  return window.innerHeight + "px";
}

const simple = ref([
  {
    id: "1",
    label: "Categoria 1",
    children: [
      {
        id: "1-1",
        label: "Markdown",
      },
      {
        id: "1-2",
        label: "parte 2",
      },
    ],
  },
  {
    id: "2",
    label: "Categoria 2",
  },
  {
    id: "3",
    label: "Categoria 3",
    children: [
      {
        id: "3-1",
        label: "parte 1",
      },
      {
        id: "3-2",
        label: "parte 2",
        children: [
          {
            id: "3-2-1",
            label: "Categoria 3 parte 2 parte 1",
          },
          {
            id: "3-2-2",
            label: "Categoria 3 parte 2 parte 2",
          },
        ],
      },
    ],
  },
  {
    id: "4",
    label: "Categoria 4",
  },
  {
    id: "5",
    label: "Categoria 5",
  },
  {
    id: "6",
    label: "Categoria 6",
  },
  {
    id: "7",
    label: "Categoria 7",
  },
  {
    id: "8",
    label: "Categoria 8",
  },
  {
    id: "9",
    label: "Categoria 9",
  },
  {
    id: "10",
    label: "Categoria 10",
  },
]);

function findLabelById(list, id) {
  let returntag = list.find((tag) => {
    return tag.id === id;
  })?.label;
  if (returntag) return returntag;
  list.forEach((tag) => {
    let sublist = tag?.children;
    if (sublist) {
      let subtag = findLabelById(sublist, id);
      if (subtag) {
        returntag = subtag;
      }
    }
  });
  return returntag;
}

const selectedTag = computed(() => {
  return findLabelById(simple.value, selected.value);
});
</script>
