import './ChartBar.css'

export default function ChartBar(props) {
  const barFillHeight = props.maxValue > 0 ? Math.round((props.value / props.maxValue) * 100) + '%' : '0%';

  return (
    <div className='chart-bar'>
      <div className='chart-bar__inner'>
        <div
          className='chart-bar__fill'
          style={{ height: barFillHeight }}
        ></div>
      </div>
      <div className="chart-bar__label">{props.label}</div>
    </div>
  );
}