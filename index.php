<?php
$username = "root";
$password = "Eme#8710";
$database = "studio_yoga";

try {
    $pdo = new PDO("mysql:host=localhost;dbname=$database", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("ERROR: Could not connect. " . $e->getMessage());
}

function formatarNomeMes($nomeMes) {
    $mesesEmPortugues = array(
        "January" => "Janeiro",
        "February" => "Fevereiro",
        "March" => "Março",
        "April" => "Abril",
        "May" => "Maio",
        "June" => "Junho",
        "July" => "Julho",
        "August" => "Agosto",
        "September" => "Setembro",
        "October" => "Outubro",
        "November" => "Novembro",
        "December" => "Dezembro"
    );

    return $mesesEmPortugues[$nomeMes];
}

// Presença 
try {
    $sql = "SELECT MONTHNAME(dataPresenca) AS month,
            SUM(CASE WHEN presente = true THEN 1 ELSE 0 END) AS presencas,
            SUM(CASE WHEN presente = false THEN 1 ELSE 0 END) AS faltas
            FROM Presencas
            GROUP BY month";
    $result = $pdo->query($sql);

    if ($result->rowCount() > 0) {
        $monthLabels = array();
        $presencasPorMes = array();
        $faltasPorMes = array();
        while ($row = $result->fetch()) {
            $monthLabels[] = formatarNomeMes($row["month"]);
            $presencasPorMes[] = $row["presencas"];
            $faltasPorMes[] = $row["faltas"];
        }

        unset($result);
    } else {
        echo "No records matching your query were found.";
    }
} catch (PDOException $e) {
    die("ERROR: Could not able to execute $sql. " . $e->getMessage());
}


// Receita por Mês
try {
    $sqlReceita = "SELECT MONTHNAME(dataPagamento) AS month,
            SUM(valor) AS receita
            FROM Pagamentos
            GROUP BY month";
    $resultReceita = $pdo->query($sqlReceita);

    if ($resultReceita->rowCount() > 0) {
        $monthLabels2 = array();
        $receitaPorMes = array();
        while ($row = $resultReceita->fetch()) {
            $monthLabels2[] = formatarNomeMes($row["month"]);
            $receitaPorMes[] = $row["receita"];
        }

        unset($resultReceita);
    } else {
        echo "No records matching your query were found.";
    }
} catch (PDOException $e) {
    die("ERROR: Could not able to execute $sqlReceita. " . $e->getMessage());
}

//Vendas 

try {
    $sqlVendas = "SELECT P.nome AS produto, SUM(V.quantidade) AS quantidadeVendida
                  FROM Vendas V
                  INNER JOIN Produtos P ON V.idProduto = P.idProduto
                  WHERE MONTH(V.dataVenda) IN (2, 3, 4, 5)
                  GROUP BY P.idProduto";
    
    $resultVendas = $pdo->query($sqlVendas);

    if ($resultVendas->rowCount() > 0) {
        $produtoNome3 = array();
        $quantidadeVendida = array();
        
        while ($row = $resultVendas->fetch()) {
            $produtoNome3[] = $row["produto"];
            $quantidadeVendida[] = $row["quantidadeVendida"];
        }

        unset($resultVendas);
    } else {
        echo "No records matching your query were found.";
    }
} catch (PDOException $e) {
    die("ERROR: Could not able to execute $sqlVendas. " . $e->getMessage());
}

// Feedbacks por Mês
try {
    $sqlFeedback = "SELECT
                        MONTHNAME(F.dataFeedback) AS month,
                        SUM(CASE WHEN F.tipoAvaliacao = 'bom' THEN 1 ELSE 0 END) AS feedbackBom,
                        SUM(CASE WHEN F.tipoAvaliacao = 'ótimo' THEN 1 ELSE 0 END) AS feedbackOtimo,
                        SUM(CASE WHEN F.tipoAvaliacao = 'ruim' THEN 1 ELSE 0 END) AS feedbackRuim
                    FROM FeedbackAlunos F
                    GROUP BY month";
    $resultFeedback = $pdo->query($sqlFeedback);

    if ($resultFeedback->rowCount() > 0) {
        $monthLabels4 = array();
        $feedbackBom = array();
        $feedbackOtimo = array();
        $feedbackRuim = array();

        while ($row = $resultFeedback->fetch()) {
            $monthLabels4[] = formatarNomeMes($row["month"]);
            $feedbackBom[] = $row["feedbackBom"];
            $feedbackOtimo[] = $row["feedbackOtimo"];
            $feedbackRuim[] = $row["feedbackRuim"];
        }

        unset($resultFeedback);
    } else {
        echo "No records matching your query were found.";
    }
} catch (PDOException $e) {
    die("ERROR: Could not able to execute $sqlFeedback. " . $e->getMessage());
}



// Close connection
unset($pdo);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gráficos</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

<aside>
  
    <p style="font-style: strong; font-size: 34px;">Filtros</p>

    <label for="">Mês e Ano</label>
    <input type="month" style="height: 30px;">


</aside>

<main>
    <div class="charts">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <div class="chart1">
            <canvas id="myChart1"></canvas>
            <script>
                // Setup block
                const monthLabels = <?php echo json_encode($monthLabels); ?>;
                const presencasPorMes = <?php echo json_encode($presencasPorMes); ?>;
                const faltasPorMes = <?php echo json_encode($faltasPorMes); ?>;

                const data = {
                    labels: monthLabels,
                    datasets: [
                        {
                            label: 'Presenças em aula',
                            data: presencasPorMes,
                            borderColor: 'green',
                            backgroundColor: 'rgba(0, 255, 0, 0.2)',
                            borderWidth: 1
                        },
                        {
                            label: 'Faltas em aula',
                            data: faltasPorMes,
                            borderColor: 'red',
                            backgroundColor: 'rgba(255, 0, 0, 0.2)',
                            borderWidth: 1
                        }
                    ]
                };

                // Config block
                const config = {
                    type: 'line',
                    data,
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                };

                // Render block
                const myChart = new Chart(
                    document.getElementById('myChart1'),
                    config
                );
            </script>
        </div>



                <div class="chart2">
            <canvas id="myChart2"></canvas>
            <script>
                // Setup block
                const monthLabels2 = <?php echo json_encode($monthLabels2); ?>;
                const receitaPorMes = <?php echo json_encode($receitaPorMes); ?>;

                const data2 = {
                    labels: monthLabels2,
                    datasets: [{
                        label: 'Receita por mês',
                        data: receitaPorMes,
                        borderColor: 'blue',
                        backgroundColor: 'rgba(0, 0, 255, 0.2)',
                        borderWidth: 1
                    }]
                };

                // Config block
                const config2 = {
                    type: 'bar',
                    data: data2,
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                };

                // Render block
                const myChart2 = new Chart(
                    document.getElementById('myChart2'),
                    config2
                );
            </script>
        </div>




        <div class="chart3">
            <canvas id="myChart3"></canvas>
            <script>
                // Setup block
                const produtoNome3 = <?php echo json_encode($produtoNome3); ?>;
                const quantidadeVendida = <?php echo json_encode($quantidadeVendida); ?>;

                const data3 = {
                    labels: produtoNome3,
                    datasets: [{
                        data: quantidadeVendida,
                        backgroundColor: [
                            'red',
                            'blue',
                            'yellow',
                        ],
                        borderWidth: 1
                    }]
                };

                // Config block
                const config3 = {
                    type: 'pie',
                    data: data3,
                    options: {
                        plugins: {
                            title: {
                                display: true,
                                text: 'Produtos Vendidos',
                                font: {
                                    size: 16
                                }
                            },

                            
                        }
                    }
                };

                // Render block
                const myChart3 = new Chart(
                    document.getElementById('myChart3'),
                    config3
                );
            </script>
        </div>

        <div class="chart4">
            <canvas id="myChart4"></canvas>
            <script>
                // Setup block
                const monthLabels4 = <?php echo json_encode($monthLabels4); ?>;
                const feedbackBom = <?php echo json_encode($feedbackBom); ?>;
                const feedbackOtimo = <?php echo json_encode($feedbackOtimo); ?>;
                const feedbackRuim = <?php echo json_encode($feedbackRuim); ?>;

                const data4 = {
                    labels: monthLabels4,
                    datasets: [
                        {
                            label: 'Bom',
                            data: feedbackBom,
                            backgroundColor: 'rgba(0, 128, 0, 0.5)',
                            borderWidth: 1
                        },
                        {
                            label: 'Ótimo',
                            data: feedbackOtimo,
                            backgroundColor: 'rgba(255, 255, 0, 0.5)',
                            borderWidth: 1
                        },
                        {
                            label: 'Ruim',
                            data: feedbackRuim,
                            backgroundColor: 'rgba(255, 0, 0, 0.5)',
                            borderWidth: 1
                        }
                    ]
                };

                // Config block
                const config4 = {
                    type: 'bar',
                    data: data4,
                    options: {
                        scales: {
                            x: {
                                beginAtZero: true
                            },
                        },
                        indexAxis: 'y',
                        plugins: {
                            title: {
                                display: true,
                                text: 'Feedback das aulas',
                                font: {
                                    size: 16
                                }
                            }
                        }
                    }
                };

                // Render block
                const myChart4 = new Chart(
                    document.getElementById('myChart4'),
                    config4
                );
            </script>
        </div>


        
    </div>

</main>

</body>
</html>
