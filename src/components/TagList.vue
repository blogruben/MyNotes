<template>
  <div class="q-gutter-xs q-pl-sm q-pt-sm">
    <div class="row">
      <div class="text-h6 q-pl-sm q-pt-xs text-white">Tags</div>
      <q-btn flat round color="white" size="0.7em" icon="style" />
    </div>
  </div>

  <div class="col">
    <q-scroll-area
      :visible="true"
      :thumb-style="thumbStyle"
      style="height: 100%"
    >
      <q-tree
        color="secondary"
        :nodes="simple"
        node-key="id"
        no-connectors
        dense
        v-model:expanded="expanded"
        selected-color=" bg-negative rounded-borders"
        v-model:selected="selectedTagId"
        no-selection-unset
        @click="$emit('update', selectedTag)"
      >
        <template v-slot:default-header="prop">
          <div class="row justify-between full-width">
            <div class="col-10">
              <div
                :class="
                  selectedTagId === prop.node.id
                    ? 'text-black text-weight-bold q-ml-xs'
                    : 'text-white q-ml-xs'
                "
              >
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
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onBeforeMount } from "vue";

//variables
const thumbStyle = {
  right: "4px",
  borderRadius: "5px",
  backgroundColor: "#704214",
  width: "5px",
  opacity: 0.8,
};

//propiedades computadas
const selectedTag = computed(() => {
  return findLabelById(simple.value, selectedTagId.value);
});

//funciones
function findLabelById(list, id) {
  let returntag = list.find((tag) => {
    return tag.id === id;
  });
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

//TODO modificador de evento
function editTag(selectTag) {
  setTimeout(function () {
    alert("Edit Tag:  " + selectedTag.value);
  }, 300);
}
const emit = defineEmits(["update"]);

onMounted(() => {
  //console.log("Se ha montado el componente: " + selectedTag.value);
  emit("update", selectedTag.value);
});

//variables reactivas
const expanded = ref(["3"]);
const selectedTagId = ref("2");
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
