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
        <q-scroll-area
          :thumb-style="thumbStyle"
          :bar-style="barStyle"
          style="height: 100%"
        >
          <div class="row q-gutter-xs q-ml-sm q-mt-sm">
            <div class="text-h6">Tags</div>
            <q-fab
              color="none"
              flat
              push
              icon="sell"
              direction="right"
              padding="xs"
            >
              <q-fab-action
                color="primary"
                @click="console.log('ver las notas eliminadas...')"
                icon="delete"
                padding="xs"
              />
              <q-fab-action
                color="primary"
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
            v-model:selected="selectedTagId"
            no-selection-unset
            @click="console.log('Tag selected: ' + selectedTagId)"
          >
            <template v-slot:default-header="prop">
              <div class="row justify-between full-width">
                <div class="col-10">
                  <div class="text-weight-bold text-primary">
                    {{ prop.node.label }}
                  </div>
                </div>

                <div class="col-2">
                  <q-btn
                    flat
                    padding="none"
                    color="secondary"
                    icon="more_horiz"
                    @click="editTag"
                  />
                </div>
              </div>
            </template>
          </q-tree>
        </q-scroll-area>
      </template>

      <template #after>
        <q-scroll-area
          :thumb-style="thumbStyle"
          :bar-style="barStyle"
          style="height: 100%"
        >
          <div class="text-h6 q-ml-md q-mt-sm">{{ selectedTag }}</div>
          <q-list dense separator>
            <q-item clickable v-ripple v-for="n in 20" :key="n">
              <q-item-section>
                <q-item-label :class="estilo" @click="selectNote(n)"
                  >Nota numero {{ n }}</q-item-label
                >
              </q-item-section>
            </q-item>
          </q-list>
        </q-scroll-area>
      </template>
    </q-splitter>
  </div>
</template>

<script setup>
import { ref, computed } from "vue";

//Calculate height in pixel
const height = ref("height: " + window.innerHeight + "px");
window.addEventListener("resize", reportWindowSize);
function reportWindowSize() {
  height.value = "height: " + window.innerHeight + "px";
}

//variables
const thumbStyle = {
  right: "4px",
  borderRadius: "5px",
  backgroundColor: "#027be3",
  width: "5px",
  opacity: 0.75,
};

const barStyle = {
  right: "2px",
  borderRadius: "9px",
  backgroundColor: "#027be3",
  width: "9px",
  opacity: 0.2,
};

//propiedades computadas
const selectedTag = computed(() => {
  return findLabelById(simple.value, selectedTagId.value);
});

const estilo = computed(() => {
  return {
    "bg-dark": selectedNote.value === "2",
    "text-white": selectedNote.value === "2",
  };
});

//funciones
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

function editTag(selectTag) {
  setTimeout(function () {
    alert("Edit Tag:  " + selectedTag.value);
  }, 300);
}

function selectNote(id) {
  console.log("Note selected: " + id);
}

//variables reactivas
const insideModel = ref(40);
const expanded = ref(["3"]);
const selectedTagId = ref("2");
const selectedNote = ref(2);
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
</script>
