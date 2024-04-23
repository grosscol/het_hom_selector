REF="/net/share/ftp/vt/grch38/hs38DH.fa"

# Args: ($1) prefix, ($2) range, ($3) array of crams
#   process_crams "DUP_1" "chr20:20200-20600" CRAM_ARR
function process_crams() { 
  local L_PREFIX=$(echo $1 | tr '[:upper:]' '[:lower:]')
  local OUT_FA="${L_PREFIX}.fa"
  shift
  local L_RANGE=$1
  local TMP_BED=/tmp/${L_RANGE}.bed
  shift
  local L_CRAMS=("$@")

  # Create temp bedfile and subset fasta
  echo $L_RANGE | tr ':-' '\t' > /tmp/${L_RANGE}.bed
  bedtools getfasta -fi ${REF} -bed ${TMP_BED} -fo ${OUT_FA}

  # Subset and convert cram to sams
  local L_IDX=1
  for CRAM in ${L_CRAMS[@]}; do
    local OUT_SAM="${L_PREFIX}_sample_${L_IDX}.sam"
    echo $OUT_SAM
    samtools view --with-header --reference ${REF} $CRAM ${L_RANGE} > ${OUT_SAM}

    let "L_IDX++"
  done
}

PREFIX=dup_1
RANGE=chr1:820200-823600
CRAMS=(\
  "/net/topmed10/working/mapping/results/broad/Ellinor/b38/NWD871213/NWD871213.recab.cram" \
  "/net/topmed6/incoming/mapping/results/broad/Silverman/b38/NWD912182/NWD912182.recab.cram")
process_crams ${PREFIX} ${RANGE} ${CRAMS[@]}


PREFIX=dup_2
RANGE=chr1:50186563-50186750
CRAMS=(\
  "/net/topmed9/working/mapping/results/broad/Ellinor/b38/NWD625108/NWD625108.recab.cram" \
  "/net/topmed7/incoming/mapping/results/broad/Kooperberg/b38/NWD223005/NWD223005.recab.cram" \
  "/net/topmed10/working/mapping/results/broad/Rotter/b38/NWD373672/NWD373672.recab.cram" \
  "/net/topmed9/incoming/mapping/results/broad/Rotter/b38/NWD729473/NWD729473.recab.cram" \
  "/net/topmed9/working/mapping/results/broad/Kooperberg/b38/NWD526679/NWD526679.recab.cram")
process_crams ${PREFIX} ${RANGE} ${CRAMS[@]}

PREFIX=dup_3
RANGE=chr1:50186563-50186750
CRAMS=(\
  "/net/topmed9/working/mapping/results/broad/Ellinor/b38/NWD625108/NWD625108.recab.cram" \
  "/net/topmed7/incoming/mapping/results/broad/Kooperberg/b38/NWD223005/NWD223005.recab.cram" \
  "/net/topmed10/working/mapping/results/broad/Rotter/b38/NWD373672/NWD373672.recab.cram" \
  "/net/topmed9/incoming/mapping/results/broad/Rotter/b38/NWD729473/NWD729473.recab.cram" \
  "/net/topmed9/working/mapping/results/broad/Kooperberg/b38/NWD526679/NWD526679.recab.cram")
process_crams ${PREFIX} ${RANGE} ${CRAMS[@]}

PREFIX=inv_1
RANGE=chr1:13711888-13712053
CRAMS=("/net/topmed10/incoming/mapping/results/broad/Kooperberg/b38/NWD869045/NWD869045.recab.cram")
process_crams ${PREFIX} ${RANGE} ${CRAMS[@]}

# Example DEL_1
# chr1    50178941        DEL_1:50178942-50179523 A       <DEL>           NWD962610,NWD764758,NWD613849
PREFIX=del_1
RANGE=chr1:50178942-50179523
CRAMS=(\
  "/net/topmed7/incoming/mapping/results/broad/Silverman/b38/NWD962610/NWD962610.recab.cram" \
  "/net/topmed5/incoming/mapping/results/washu/Schwartz/b38/NWD764758/NWD764758.recab.cram" \
  "/net/topmed/working/mapping/results/washu/Schwartz/b38/NWD613849/NWD613849.recab.cram")
process_crams ${PREFIX} ${RANGE} ${CRAMS[@]}

